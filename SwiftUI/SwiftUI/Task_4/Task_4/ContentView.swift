//
//  ContentView.swift
//  Task_4
//
//  Created by Seda Kirakosyan on 10.08.25.
//

import SwiftUI

import SwiftUI

struct ColorChangingToggleStyle: ToggleStyle {
    var onColor: Color = .pink
    var offColor: Color = .gray.opacity(0.6)
    var thumbColor: Color = .white
    var size: CGSize = CGSize(width: 56, height: 32)

    func makeBody(configuration: Configuration) -> some View {
        let corner = size.height / 2
        let thumbInset: CGFloat = 3
        let thumbSize = CGSize(width: size.height - thumbInset*2, height: size.height - thumbInset*2)
        let onOffset = size.width/2 - thumbSize.width/2 - thumbInset
        let offOffset = -(size.width/2 - thumbSize.width/2 - thumbInset)

        return HStack(spacing: 12) {
            configuration.label
                .foregroundColor(configuration.isOn ? .white : .black)

            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: size.width, height: size.height)
                    .overlay(
                        RoundedRectangle(cornerRadius: corner, style: .continuous)
                            .strokeBorder(.black.opacity(0.08))
                    )

                Circle()
                    .fill(thumbColor)
                    .frame(width: thumbSize.width, height: thumbSize.height)
                    .shadow(radius: 1, y: 1)
                    .offset(x: configuration.isOn ? onOffset : offOffset)
                    .animation(.easeInOut(duration: 0.18), value: configuration.isOn)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.18)) {
                    configuration.isOn.toggle()
                }
            }
            .accessibilityAddTraits(.isButton)
            .accessibilityValue(configuration.isOn ? Text("On") : Text("Off"))
        }
    }
}


struct ContentView: View {
    @State var isDarkMode: Bool = false
    var body: some View {
        ZStack {
            (isDarkMode ? Color.black : Color.white)
                .ignoresSafeArea()
            Toggle(isDarkMode ? "Dark Mode": "Light Mode" , isOn: $isDarkMode)
                .toggleStyle(ColorChangingToggleStyle())
                .padding()
        }
        
    }
}

#Preview {
    ContentView()
}
