//
//  SwiftUIView.swift
//  Task_4
//
//  Created by Seda Kirakosyan on 23.08.25.
//

import SwiftUI

struct MixedView: View {

    var body: some View {
        VStack(spacing: 16) {
            Text("SwiftUI label above")
                .font(.headline)

            UIKitView()
                .frame(height: 100)

            Text("SwiftUI label below")
                .font(.subheadline)
            
        }
        .padding()
    }
}


struct UIKitView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        ViewController()
    }
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
    
}

#Preview {
    MixedView()
}
