//
//  Task_1App.swift
//  Task_1
//
//  Created by Seda Kirakosyan on 22.08.25.
//

import SwiftUI

@main
struct Task_1App: App {
    @StateObject private var counter = Counter()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(counter)
        }
    }
}
