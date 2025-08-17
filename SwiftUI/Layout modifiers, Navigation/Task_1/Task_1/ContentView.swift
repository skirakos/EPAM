//
//  ContentView.swift
//  Task_1
//
//  Created by Seda Kirakosyan on 15.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("SwiftUI Layout Modifiers")
                .padding([.top, .bottom], 20)
                .background(Color.blue)
            
            Text("SwiftUI Layout Modifiers")
                .background(Color.blue)
                .padding(.top)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
