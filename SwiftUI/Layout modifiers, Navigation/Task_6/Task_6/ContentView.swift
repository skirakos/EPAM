//
//  ContentView.swift
//  Task_6
//
//  Created by Seda Kirakosyan on 15.08.25.
//
import SwiftUI

struct CustomButtonStyle: ViewModifier {
    var font: Font
    var foreground: Color
    var background: Color
    var cornerRadius: CGFloat
    
    var isEnabled: Bool
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(foreground)
            .padding()
            .background(isEnabled ? background : Color.gray)
            .cornerRadius(cornerRadius)
            
        
    }
}

extension View {
    func customButtonStyle(
        font: Font = .headline,
        foreground: Color = .white,
        background: Color = .blue,
        cornerRadius: CGFloat = 8,
        isEnabled: Bool
    ) -> some View {
        self.modifier(CustomButtonStyle(
            font: font,
            foreground: foreground,
            background: background,
            cornerRadius: cornerRadius,
            isEnabled: isEnabled
        ))
    }
}

struct ContentView: View {
    @State var isEnabledA = true
    @State var isEnabledB = true
    
    var body: some View {
        VStack {
            Button("Some Button") {
                isEnabledA.toggle()
                
            }
            .customButtonStyle(isEnabled: isEnabledA)
            
            Button("Danger") {
                isEnabledB.toggle()
            }
                .customButtonStyle(
                    font: .title2,
                    foreground: .white,
                    background: .red,
                    cornerRadius: 12,
                    isEnabled: isEnabledB
                )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
