//
//  ContentView.swift
//  Task_1
//
//  Created by Seda Kirakosyan on 16.08.25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to SwiftUI!")
                    .font(.title)
                    .bold()
                NavigationLink(destination: Text("Hello, SwiftUI Navigation!")) {
                    Text("Go")
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ContentView()
}
