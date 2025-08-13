//
//  ContentView.swift
//  Task_5
//
//  Created by Seda Kirakosyan on 12.08.25.
//

import SwiftUI

struct CardView<Content: View>: View {
    let title: String
    private let content: Content

    init(title: String, @ViewBuilder _ content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            content
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                CardView(title: "Jane Doe") {
                    HStack(spacing: 12) {
                        Image(systemName: "person.circle.fill")
                            .resizable().frame(width: 40, height: 40)
                        VStack(alignment: .leading) {
                            Text("iOS Developer").foregroundColor(.secondary)
                            Text("Yerevan").font(.caption).foregroundColor(.secondary)
                        }
                    }
                }

                CardView(title: "Ann Smith") {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Web Developer").foregroundColor(.secondary)
                        HStack {
                            Image(systemName: "link")
                            Text("annsmith.dev")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                }

                CardView(title: "Actions") {
                    HStack {
                        Button("Follow") {}
                            .buttonStyle(.borderedProminent)
                        Button("Message") {}
                            .buttonStyle(.bordered)
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}

#Preview { ContentView() }
