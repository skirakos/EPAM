//
//  ContentView.swift
//  Task_5
//
//  Created by Seda Kirakosyan on 17.08.25.
//

import SwiftUI
import Observation

@Observable
class FormModel {
    var username: String = ""
}

struct ContentView: View {
    @State private var model: FormModel = .init()
    
    var body: some View {
        @Bindable var formModel = model
        VStack {
            TextField("Username", text: $formModel.username)
                .textFieldStyle(.roundedBorder)
            
            Button("Submit") {
                print("Username: \(formModel.username)")
            }
            .buttonStyle(.borderedProminent)
            .disabled(formModel.username.isEmpty)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
