//
//  ContentView.swift
//  Task_2
//
//  Created by Seda Kirakosyan on 23.08.25.
//

import SwiftUI

class TaskManager: ObservableObject {
    @Published var tasks: [String] = ["Task 1", "Task 2", "Task 3"]
}

struct RootView: View {
    @EnvironmentObject var taskManager: TaskManager
    
    var body: some View {
        VStack {
            TaskListView()
            AddTaskView()
            RemoveTaskView()
        }
    }
}

struct TaskListView: View {
    @EnvironmentObject var taskManager: TaskManager
    
    var body: some View {
        List {
            ForEach(taskManager.tasks, id: \.self) { task in
                Text(task)
            }
        }
    }
}
struct AddTaskView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var newTask: String = ""
    
    var body: some View {
        HStack {
            TextField("Add task", text: $newTask)
            Button(action: {
                self.taskManager.tasks.append(newTask)
                newTask = ""
            }) {
                Text("Add")
            }
            .buttonStyle(.borderedProminent)
            .disabled(newTask.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding()
    }
}

struct RemoveTaskView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var indexText: String = ""
    
    private var isValidIndex: Bool {
        guard let i = Int(indexText.trimmingCharacters(in: .whitespaces)) else { return false }
        return taskManager.tasks.indices.contains(i)
    }
    
    var body: some View {
        HStack {
            TextField("Remove the task with index ...", text: $indexText)
            Button("Remove") {
                guard
                    let i = Int(indexText.trimmingCharacters(in: .whitespaces)),
                    taskManager.tasks.indices.contains(i)
                else { return }
                taskManager.tasks.remove(at: i)
                indexText = ""
            }
            .buttonStyle(.borderedProminent)
            .disabled(!isValidIndex)
        }
        .padding()
    }
}

#Preview {
    RootView()
        .environmentObject(TaskManager())
}
