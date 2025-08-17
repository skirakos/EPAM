//
//  ContentView.swift
//  Task_4
//
//  Created by Seda Kirakosyan on 16.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home View")
                    .font(.largeTitle).bold()
            }
            .toolbarBackground(Color.blue.opacity(0.3), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("My App")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 5)
                        
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                        }
                    }
                }
                
            }
        }
    }
}

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("⚙️ Settings")
                .font(.largeTitle).bold()
        }
        .navigationBarHidden(true)
    }
}


#Preview {
    ContentView()
}
