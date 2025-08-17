//
//  ContentView.swift
//  Task_2
//
//  Created by Seda Kirakosyan on 17.08.25.
//

import SwiftUI

struct ContentView: View {
    @State private var isOn: Bool = true
    var body: some View {
        VStack(spacing: 20) {
            Toggle("Show Greeting", isOn: $isOn)
                .padding()

            if isOn {
                Text("Hello, SwiftUI!")
                    .font(.title)
                    .bold()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
