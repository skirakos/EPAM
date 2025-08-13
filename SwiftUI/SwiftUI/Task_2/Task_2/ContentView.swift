//
//  ContentView.swift
//  Task_2
//
//  Created by Seda Kirakosyan on 10.08.25.
//

import SwiftUI

struct ContentView: View {
    let names: [String] = ["Anna", "Alice", "Bob", "Charlie"]
    
    var body: some View {
        List (names, id: \.self) { name in
            HStack {
                Text(name)
                Spacer()
                Button(action: {print(name)}) {
                    Text("Click me")
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
