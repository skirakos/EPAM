//
//  Task4View.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 08/07/2024.
//
import SwiftUI

struct Task4View: View {
    var api = Task4ViewAPI()
    @State var finished: Bool = false
    @State var ballance: Int = 1000
    
    var body: some View {
        VStack {
            Text("Starting ballance: 1000")
            if finished {
                Text("Final balance: \(ballance)")
                Text(ballance == 0 ? "Success" : "Failure")
            }
            Button {
                if finished {
                    api.ballance = 1000
                    finished = false
                } else {
                    Task {
                        ballance = await api.startUpdate()
                        self.finished = true
                    }
                }
            } label: {
                if finished {
                    Text("Reset")
                } else {
                    Text("Start")
                }
            }
        }
    }
}

#Preview {
    Task4View()
}

actor Task4ViewAPI: @unchecked Sendable {
    var ballance: Int = 1000
    
    func startUpdate() async -> Int {
        await withTaskGroup(of: Void.self) { group in
            for _ in 0...999 {
                group.addTask { [weak self] in
                    await self?.decrement()
                }
            }
        }
        
        return ballance
    }
    
    func decrement() {
        ballance -= 1
    }
}
