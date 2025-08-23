//
//  SwiftUIView.swift
//  Task_3
//
//  Created by Seda Kirakosyan on 23.08.25.
//

import SwiftUI

struct SwiftUIView: View {
    let dismiss: () -> Void
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button("Dismiss") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
}

#Preview {
    SwiftUIView(dismiss: {})
}
