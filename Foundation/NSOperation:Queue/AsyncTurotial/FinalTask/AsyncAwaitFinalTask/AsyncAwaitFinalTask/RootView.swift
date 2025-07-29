//
//  ContentView.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 4/9/24.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Task 1", destination: Task1View()).padding()
                NavigationLink("Task 2", destination: Task2View()).padding()
                NavigationLink("Task 3", destination: Task3View()).padding()
                NavigationLink("Task 4", destination: Task4View()).padding()
                NavigationLink("Task 5 (Optional)", destination: Task5View()).padding()
            }
            .padding()
        }
    }
}

#Preview {
    RootView()
}
