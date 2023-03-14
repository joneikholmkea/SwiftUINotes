//
//  ListDemo.swift
//  FirstIOSapp
//
//  Created by Jon Eikholm on 06/02/2023.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var fileMan = fService
//    @State private var path: [Int] = []
    @State private var selection = 1
    var body: some View {
        
        TabView(selection: $fileMan.selectedTab){
            NavigationStack{
                if fileMan.mapTappedNote == nil {
                    VStack{
                        HStack{
                            Button {
                                fileMan.addNote(txt: "New note")
                            } label: {
                                Text("Add item")
                            }
                            Spacer()
                            
                        }.padding(10)
                        List($fileMan.notes, editActions: .all){ note in
                            NavigationLink(destination: DetailView(note: note.wrappedValue, selection: $selection)){
                                Text(note.text.wrappedValue)
                            }
                        }
                    }
                }else{
                    DetailView(note: fileMan.mapTappedNote!, selection: $selection)
                }
                
            }.tabItem{
                Label("Home", systemImage: "house")
            }.tag(1)
    
            MapWrap(selection: $selection)
                .tabItem{
                    Label("Map", systemImage: "map")
                }
                .tag(2)
        }

    }
}

struct ListDemo_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}



//NavigationStack(path: $path){
//        VStack{
//            HStack{
//                Button {
//                    fileMan.addNote(txt: "New note")
//                } label: {
//                    Text("Add item")
//                }
//                Spacer()
////                        NavigationLink(destination: MapWrap()){
////                            Text("Map")
////                        }
//                Button {
//                    path.append(1)
//                } label: {
//                    Text("Map")
//                }
//            }.padding(10)
//            List($fileMan.notes, editActions: .all){ note in
//                NavigationLink(destination: DetailView(note: note.wrappedValue, path: $path)){
//                    Text(note.text.wrappedValue)
//                }
//            }
//        }.navigationDestination(for: Int.self){ int in
//            if let note = fileMan.mapTappedNote{
//                DetailView(note: note, path: $path)
//            }else{
//                MapWrap()
//            }
//
//        }
//
//}
