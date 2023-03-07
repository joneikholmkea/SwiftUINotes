//
//  ListDemo.swift
//  FirstIOSapp
//
//  Created by Jon Eikholm on 06/02/2023.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var fileMan = fService
    var show = false
    var body: some View {
            NavigationStack{
                if let note = fileMan.mapTappedNote{
                    DetailView(note: note)
                }else{
                VStack{
                    HStack{
                        Button {
                            fileMan.addNote(txt: "New note")
                        } label: {
                            Text("Add item")
                        }
                        Spacer()
                        NavigationLink(destination: MapWrap()){
                            Text("Map")
                        }
                    }.padding(10)
                    List($fileMan.notes, editActions: .all){ note in
                        NavigationLink(destination: DetailView(note: note.wrappedValue)){
                            Text(note.text.wrappedValue)
                        }
                    }
                }
            }
        }
        
    }
}

struct ListDemo_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
