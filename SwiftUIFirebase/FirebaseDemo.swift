//
//  FirebaseDemo.swift
//  SwiftUIFirebase
//
//  Created by Jon Eikholm on 21/02/2023.
//

import Foundation
import Firebase

class FirebaseDemo:ObservableObject{
    private var db = Firestore.firestore() // holds the database object
    private let collection = "notes"
    @Published var notes = [Note]()
    
    func addItem(text:String){
        let doc = db.collection(collection).document() // creates a new empty document
        var data = [String:String]()  // empty map
        data["text"] = text
        doc.setData(data)
    }
    
    func startListener(){
        db.collection(collection).addSnapshotListener { snap, error in
            if error == nil {
                if let s = snap {
                    self.notes.removeAll()
                    for doc in s.documents {
                        if let str = doc.data()["text"] as? String{
                            print(str)
                            let n = Note(id: doc.documentID, text: str)
                            self.notes.append(n)
                        }
                    }
                }
            }
            
            
        }
        
    }
}
