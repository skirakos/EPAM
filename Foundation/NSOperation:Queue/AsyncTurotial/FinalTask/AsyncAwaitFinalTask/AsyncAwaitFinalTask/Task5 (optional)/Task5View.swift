//
//  Task5View.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 12/07/2024.
//

import SwiftUI
import Observation

struct Task5View: View {
    let model = Task5ViewModel()
    
    var body: some View {
        VStack {
            Text(model.displayedText)
            Text(model.loadedSequence)
            Button {
                self.model.buttonPressed()
            } label: {
                Text(model.buttonTitle)
            }
        }
    }
}

enum ParallelRequest: String {
    case one, two, three
}

protocol Task5API {
    func loadRequest(_ request: ParallelRequest) async -> String
}


@Observable
class Task5ViewModel: @unchecked Sendable {
    var displayedText = "Not running"
    let buttonTitle = "Start"
    var loadedSequence = "loaded sequence: "
    
    private var api: Task5API
    private var totalStepsLoaded = 0
    private var inProgress = false
    
    init(api: Task5API = Task5APIImpl()) {
        self.api = api
    }
    
    func buttonPressed() {
        guard !inProgress else { return }
        
        inProgress = true
        totalStepsLoaded = 0
        
        displayedText = "loaded \(totalStepsLoaded) of 3"
        loadedSequence = "loaded sequence: "
        
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    await self.processResult(await self.api.loadRequest(.one))
                }
                
                group.addTask {
                    await self.processResult(await self.api.loadRequest(.two))
                }
                
                group.addTask {
                    await self.processResult(await self.api.loadRequest(.three))
                }
            }
        }
    }
    
    @MainActor
    private func processResult(_ result: String) {
        totalStepsLoaded += 1
        
        if totalStepsLoaded > 0 {
            loadedSequence += " "
        }
        
        loadedSequence += "["+result+"]"
        
        if totalStepsLoaded == 3 {
            inProgress = false
            displayedText = "Completed"
        } else {
            displayedText = "loaded \(totalStepsLoaded) of 3"
        }
    }
    
}

class Task5APIImpl: Task5API, @unchecked Sendable {
    func loadRequest(_ request: ParallelRequest) async -> String {
        try? await Task.sleep(for: .seconds(Int.random(in: 1...4)))
        return request.rawValue
    }
}

#Preview {
    Task5View()
}
