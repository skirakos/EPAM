//
//  ContentView.swift
//  Task_4
//
//  Created by Seda Kirakosyan on 17.08.25.
//

import Observation
import SwiftUI

@Observable
class UserProfile {
    var name: String = "unknown"
    var email: String = "unknown"
}

struct ContentView: View {
    @State var userProfile: UserProfile = .init()
    var body: some View {
        @Bindable var profile = userProfile
        
        VStack(alignment: .leading, spacing: 16) {
            Text("Hello \(profile.name).\nYour email is \(profile.email).")
                .font(.headline)

            TextField("Name", text: $profile.name)
                .textFieldStyle(.roundedBorder)

            TextField("Email", text: $profile.email)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
        }
        .padding()
    }
}

//struct ContentView: View {
//    @State var userProfile: UserProfile = .init()
//    var body: some View {
//        
//        VStack(alignment: .leading, spacing: 16) {
//            Text("Hello \(userProfile.name).\nYour email is \(userProfile.email).")
//                .font(.headline)
//
//            TextField("Name", text: $userProfile.name)
//                .textFieldStyle(.roundedBorder)
//
//            TextField("Email", text: $userProfile.email)
//                .textFieldStyle(.roundedBorder)
//                .textInputAutocapitalization(.never)
//                .keyboardType(.emailAddress)
//                .autocorrectionDisabled()
//        }
//        .padding()
//    }
//}



#Preview {
    ContentView()
}

