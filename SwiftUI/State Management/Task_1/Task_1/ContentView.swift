//
//  ContentView.swift
//  Task_1
//
//  Created by Seda Kirakosyan on 17.08.25.
//

import SwiftUI

struct ContentView: View {
    @State private var counter: Int = 0
    
    var body: some View {
        VStack {
            Text("Counter: \(counter)")
            Button("+1") {
                counter += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
