//
//  Task3View.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 05/07/2024.
//

import SwiftUI

struct Task3View: View {
    @State var currentStrength: Task3API.SignalStrenght = .unknown
    @State var running: Bool = false
    
    let api = Task3API()
    
    var body: some View {
        VStack {
            HStack {
                Text("Current signal strength: \(currentStrength)")
            }
            Button {
                if running {
                    running.toggle()
                    api.cancel()
                } else {
                    running.toggle()
                    Task {
                        let stream = api.signalStrength()
                        for await strength in stream {
                            currentStrength = strength
                        }
                        currentStrength = .unknown
                        print("stream finished")
                    }
                }
            } label: {
                if running {
                    Text("Cancel")
                } else {
                    Text("Start monitoring")
                }
            }

        }
    }
}

@MainActor
class Task3API {
    private var continuation: AsyncStream<SignalStrenght>.Continuation?
    private var isCancelled = false
    
    enum SignalStrenght: String {
        case weak, strong, excellent, unknown
    }
    
    func signalStrength() -> AsyncStream<SignalStrenght> {
        isCancelled = false
        
        return AsyncStream { continuation in
            self.continuation = continuation

            Task {
                while !self.isCancelled {
                    try? await Task.sleep(for: .seconds(1))

                    let random = [SignalStrenght.weak, .strong, .excellent].randomElement()!
                    continuation.yield(random)
                }

                continuation.finish()
            }
        }
    }
    
    func cancel() {
        isCancelled = true
        continuation?.finish()
    }
}

#Preview {
    Task3View()
}
