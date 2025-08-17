//
//  ContentView.swift
//  Task_3
//
//  Created by Seda Kirakosyan on 16.08.25.
//

import SwiftUI

struct Fruit: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let info: String
}

struct ContentView: View {
    @State var fruits: [Fruit] = [
        Fruit(name: "Apple", info: "Apples are rich in fiber and vitamin C."),
        Fruit(name: "Banana", info: "Bananas are high in potassium."),
        Fruit(name: "Cherry", info: "Cherries contain antioxidants and anti-inflammatory compounds.")
    ]
    
    var body: some View {
        NavigationStack {
            List(fruits) { fruit in
                NavigationLink(value: fruit) {
                    Text(fruit.name)
                }
            }
            .navigationTitle(Text("Fruits"))
            .navigationDestination(for: Fruit.self) { fruit in
                FruitDetailView(fruit: fruit)
            }
        }
    }
}

struct FruitDetailView: View {
    let fruit: Fruit
    @State private var showInfoSheet = false

    var body: some View {
        VStack(spacing: 20) {
            Text(fruit.name)
                .font(.largeTitle).bold()

            Button("More Info") {
                showInfoSheet = true
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .sheet(isPresented: $showInfoSheet) {
            FruitInfoSheet(fruit: fruit)
        }
    }
}

struct FruitInfoSheet: View {
    let fruit: Fruit

    var body: some View {
        VStack(spacing: 20) {
            Text("ℹ️ About \(fruit.name)")
                .font(.title2).bold()

            Text(fruit.info)
                .padding()

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
