//
//  ContentView.swift
//  Task_4
//
//  Created by Seda Kirakosyan on 15.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 100, height: 100)
                .offset(x: -200, y: -400)
            
            Rectangle()
                .fill(.blue)
                .frame(width: 100, height: 100)
                .offset(x: 100, y: 100)
        }
    }
}

#Preview {
    ContentView()
}
