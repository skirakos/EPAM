//
//  Task_2App.swift
//  Task_2
//
//  Created by Seda Kirakosyan on 23.08.25.
//

import SwiftUI

@main
struct Task_2App: App {
    @EnvironmentObject var taskManager: TaskManager
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(taskManager)
        }
    }
}
