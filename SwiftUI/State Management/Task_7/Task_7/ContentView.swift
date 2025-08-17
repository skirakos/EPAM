//
//  ContentView.swift
//  Task_7
//
//  Created by Seda Kirakosyan on 17.08.25.
//

import SwiftUI
import Observation

@Observable
class CounterModel {
    var counter: Int = 0
}

struct ContentView: View {
    @State private var counter = CounterModel()
    
    var body: some View {
        HStack {
            CounterA(model: counter)
            CounterB(model: counter)
        }
        .padding()
    }
}

struct CounterA: View {
    var model: CounterModel
    
    var body: some View {
        @Bindable var model = model
        VStack {
            Text("CounterA: \(model.counter)")
            Button("+1 from A") {
                model.counter += 1
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct CounterB: View {
    var model: CounterModel
    
    var body: some View {
        @Bindable var model = model
        VStack {
            Text("CounterB: \(model.counter)")
            Button("+1 from B") {
                model.counter += 1
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}
