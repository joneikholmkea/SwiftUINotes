//
//  ContentView.swift
//  SwiftUIFirebase
//
//  Created by Jon Eikholm on 14/02/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var demoFirebase = FirebaseDemo()
    var body: some View {
        VStack {
            List($demoFirebase.notes){item in
                Text(item.text.wrappedValue)
            }
        }
        .onAppear(){
//            demoFirebase.addItem(text: "hello from View")
            demoFirebase.startListener()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
