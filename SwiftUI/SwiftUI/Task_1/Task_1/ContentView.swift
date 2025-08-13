//
//  ContentView.swift
//  Task_1
//
//  Created by Seda Kirakosyan on 09.08.25.
//

import SwiftUI

struct ContentView: View {
    @State var isON = true
    
    var body: some View {
        VStack {
            Toggle(isOn: $isON, label: { Text("Show Greeting") })
            
            if isON {
                Text("Hello, SwiftUI!")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
