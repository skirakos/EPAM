//
//  ContentView.swift
//  Task_2
//
//  Created by Seda Kirakosyan on 15.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color.red)
                .frame(width: 150, height: 100)

            Rectangle()
                .fill(Color.gray)
                .frame(width: 100, height: 80, alignment: .topTrailing)
        }

    }
}

#Preview {
    ContentView()
}
