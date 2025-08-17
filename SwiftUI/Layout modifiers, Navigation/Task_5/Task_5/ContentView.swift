//
//  ContentView.swift
//  Task_5
//
//  Created by Seda Kirakosyan on 15.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Text("SwiftUI is amazing!")
                .background(.gray)
                .overlay(
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 120, height: 120)
                )
                .frame(width: 120, height: 120)
                .clipShape(Circle())
            
            
        }
    }
}

#Preview {
    ContentView()
}
