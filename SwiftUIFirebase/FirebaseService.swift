//
//  FirebaseService.swift
//  SwiftUIFirebase
//
//  Created by Jon Eikholm on 14/02/2023.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

class FirebaseService{
    private var db = Firestore.firestore() // holds the database object
    
    
    
    let storage = Storage.storage() // for files
    private let notesColl = "notes"
    var notes = [Note]() // empty array
    var currentNoteIndex = 0
    
    func addNote(txt:String){
        let doc = db.collection(notesColl).document() // creates a new empty document
        var data = [String:String]() // creates a new empty dictionary
        data["text"] = txt
        doc.setData(data) // saves to Firestore.
    }
    
    func uploadImage(){
        let note = Note(id: UUID().description, text: "demo note")
//            let note = notes[currentNoteIndex]
            if let img = UIImage(named: "car"){
                let data = img.jpegData(compressionQuality: 1.0)!
                let imageRef = storage.reference().child(note.id)
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpeg"
                imageRef.putData(data, metadata: metaData) { meta, error in
                    if error == nil {
                        print("UPload OK")
                        //self.parentTVC?.update(image: nil)
                    }else {
                        print("upload not OK \(error)")
                    }
                }
            }
        }
    
    func downloadImage(fileName:String){
           let imageRef = storage.reference(withPath: fileName)
           imageRef.getData(maxSize: 5000000) { data, error in
               if error == nil {
                   print("Download OK")
                   let image = UIImage(data: data!)
                  // caller.imageView.image = image
                   // how to get from here to ViewController's imageView?
               }else {
                   print("Download not OK")
               }
           }
       }
    
    func startListener(){
        db.collection(notesColl).addSnapshotListener { snap, error in
            if let e = error {
                print("some error loading data \(e)")
            }else {
                if let snap = snap {
                    self.notes.removeAll()
                    for doc in snap.documents{
                        if let txt = doc.data()["text"] as? String{
                            print(txt)
                            let note = Note(id: doc.documentID, text: txt)
                            self.notes.append(note)
                        }
                    }
                }
            }
        }
    }
    
    
}
