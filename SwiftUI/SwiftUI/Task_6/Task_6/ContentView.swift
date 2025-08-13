//
//  ContentView.swift
//  Task_6
//
//  Created by Seda Kirakosyan on 13.08.25.
//

import SwiftUI

struct Grocery: Identifiable {
    let id = UUID()
    let name: String
    var isSelected: Bool
}

struct ContentView: View {
    @State private var groceries: [Grocery] = [
        .init(name: "Milk", isSelected: true),
        .init(name: "Eggs", isSelected: false),
        .init(name: "Bread", isSelected: true)
    ]
    var body: some View {
        VStack {
            List($groceries) { $item in
                HStack {
                    Text(item.name)
                        .font(.headline)
                    Spacer()
                    Toggle("", isOn: $item.isSelected)
                        .labelsHidden()
                }
//                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
