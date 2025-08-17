//
//  ContentView.swift
//  Task_3
//
//  Created by Seda Kirakosyan on 17.08.25.
//

import SwiftUI

struct NotificationToggleRow: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle("Enable Notifications", isOn: $isOn)
            .padding()
    }
}

struct ContentView: View {
    @State private var notificationsEnabled = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Notifications are \(notificationsEnabled ? "ON" : "OFF")")
                .font(.headline)
            
            NotificationToggleRow(isOn: $notificationsEnabled)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
