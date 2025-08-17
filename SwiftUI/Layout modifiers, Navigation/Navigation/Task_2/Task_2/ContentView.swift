//
//  ContentView.swift
//  Task_2
//
//  Created by Seda Kirakosyan on 16.08.25.
//

import SwiftUI

enum Route: Hashable {
    case settings
    case profile
}

struct ContentView: View {
    @State var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .navigationTitle("Home")
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .settings:
                        SettingsView(path: $path)
                    case .profile:
                        ProfileView(path: $path)
                    }
                }
        }
        
    }
}

struct HomeView: View {
    @Binding var path: [Route]

    var body: some View {
        VStack(spacing: 20) {
            Text("Home")
                .font(.title).bold()

            Button("Go to Settings") {
                path.append(.settings)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct SettingsView: View {
    @Binding var path: [Route]

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.title).bold()

            Button("Go to Profile") {
                path.append(.profile)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct ProfileView: View {
    @Binding var path: [Route]

    var body: some View {
        VStack(spacing: 20) {
            Text("Profile")
                .font(.title).bold()

            Button("Go to Home") {
                path = []
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
