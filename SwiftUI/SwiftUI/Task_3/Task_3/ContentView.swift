//
//  ContentView.swift
//  Task_3
//
//  Created by Seda Kirakosyan on 10.08.25.
//

import SwiftUI

struct Profile: Identifiable {
    let id = UUID()
    let name: String
    let img: String
    let subtitle: String
}

struct ContentView: View {
    let profiles: [Profile] = [
        Profile(name: "Seda Kirakosyan", img: "1", subtitle: "Software Engineer"),
            Profile(name: "Aram Petrosyan", img: "4", subtitle: "iOS Developer"),
            Profile(name: "Mariam Grigoryan", img: "6", subtitle: "UI/UX Designer"),
            Profile(name: "David Hakobyan", img: "4", subtitle: "Backend Engineer"),
            Profile(name: "Nare Sargsyan", img: "5", subtitle: "Product Manager")
        ]
    var body: some View {
        List(profiles) { profile in
            HStack {
                Image(profile.img)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                   .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(profile.name).font(.headline)
                    Text(profile.subtitle)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
