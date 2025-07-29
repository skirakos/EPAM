//
//  Task2View.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 4/9/24.
//

import SwiftUI

struct Task2View: View {
    let task2API: Task2API = .init()

    @State var user: Task2API.User?
    @State var products: [Task2API.Product] = []
    @State var duration: TimeInterval?

    var body: some View {
        VStack {
            if let user, !products.isEmpty, let duration {
                Text("User name: \(user.name)").padding()
                List(products) { product in
                    Text("product description: \(product.description)")
                }
                Text("it took: \(duration) second(s)")
            } else {
                Text("Loading in progress")
            }
        }.task {
            do {
                let startDate = Date.now

                enum Result {
                    case user(Task2API.User)
                    case products([Task2API.Product])
                }
                

                try await withThrowingTaskGroup(of: Result.self) { group in
                    group.addTask {
                        let u = try await task2API.getUser()
                        return .user(u)
                    }
                    
                    group.addTask {
                        let p = try await task2API.getProducts()
                        return .products(p)
                    }
                    
                    for try await result in group {
                        switch result {
                        case .user(let u):
                            user = u
                        case .products(let p):
                            products = p
                        }
                    }
                }
                let endDate = Date.now

                duration = DateInterval(start: startDate, end: endDate).duration
            } catch {
                print("unexpected error")
            }
        }
    }
}

class Task2API: @unchecked Sendable {
    struct User {
        let name: String
    }

    struct Product: Identifiable {
        let id: String
        let description: String
    }

    func getUser() async throws -> User {
        try await Task.sleep(for: .seconds(1))
        return .init(name: "John Smith")
    }
    
    func getProducts() async throws -> [Product] {
        try await Task.sleep(for: .seconds(1))
        return [.init(id: "1", description: "Some cool product"),
                .init(id: "2", description: "Some expensive product")]
    }
}

#Preview {
    Task2View()
}
