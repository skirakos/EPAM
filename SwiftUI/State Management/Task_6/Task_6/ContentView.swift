//
//  ContentView.swift
//  Task_6
//
//  Created by Seda Kirakosyan on 17.08.25.
//

import SwiftUI

struct Setting {
    let name: String
    var isOn: Bool
}

struct ContentView: View {
    @State private var settings: [Setting] = [
        Setting(name: "Wi-Fi", isOn: true),
        Setting(name: "Bluetooth", isOn: false),
        Setting(name: "Notifications", isOn: true),
        Setting(name: "Dark Mode", isOn: false),
        Setting(name: "Location Services", isOn: true)
    ]
    
    var body: some View {
        List($settings, id: \.name) { $setting in
            Toggle(setting.name, isOn: $setting.isOn)
        }
    }
}

#Preview {
    ContentView()
}
