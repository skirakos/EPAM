//
//  ContentView.swift
//  Task_3
//
//  Created by Seda Kirakosyan on 15.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(spacing: 20) {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.2))
    }
}

#Preview {
    ContentView()
}
