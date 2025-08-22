//
//  ContentView.swift
//  Task_1
//
//  Created by Seda Kirakosyan on 22.08.25.
//

import SwiftUI

class Counter: ObservableObject {
    @Published var counterValue: Int = 0
}

struct RootView: View {
    var body: some View {
        VStack(spacing: 24) {
            CounterDisplayView()
            HStack(spacing: 16) {
                DecrementCounterView()
                IncrementCounterView()
            }
        }
        .padding()
    }
}

struct CounterDisplayView: View {
    @EnvironmentObject var counter: Counter
    
    var body: some View {
        Text("Counter: \(counter.counterValue)")
            .font(.largeTitle)
    }
}

struct IncrementCounterView: View {
    @EnvironmentObject var counter: Counter
    
    var body: some View {
        Button("+1") {
            counter.counterValue += 1
        }
        .buttonStyle(.borderedProminent)
    }
}

struct DecrementCounterView: View {
    @EnvironmentObject var counter: Counter
    
    var body: some View {
        Button("-1") {
            counter.counterValue -= 1
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    RootView()
        .environmentObject(Counter())
}
