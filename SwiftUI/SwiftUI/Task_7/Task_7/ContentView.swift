//
//  ContentView.swift
//  Task_7
//
//  Created by Seda Kirakosyan on 13.08.25.
//

import SwiftUI

struct Profile: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let age: Int
    var isPremium: Bool = false
}

struct ContentView: View {
    private var profile: Profile = .init(name: "Seda Kirakosyan", location: "Yerevan", age: 21, isPremium: true)
    
    var body: some View {
        HStack {
            if profile.isPremium {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray.opacity(0.3))
                    
                    HStack {
                        Image(systemName: "crown.fill")
                    }
                    .padding(-4)
                }
                .overlay(Capsule().stroke(.black.opacity(0.1)))
                .foregroundColor(.blue)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray.opacity(0.3))
            }
            
            
            VStack(alignment: .leading) {
                
                Text(profile.name)
                    .font(.headline)
                Text("\(profile.age), \(profile.location)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        Spacer()
        
    }
}

#Preview {
    ContentView()
}
