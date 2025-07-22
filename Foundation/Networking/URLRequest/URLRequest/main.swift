//
//  main.swift
//  URLRequest
//
//  Created by Seda Kirakosyan on 09.07.25.
//

import Foundation

func fetchData() async -> Result<[User], Error> {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
        return .failure(NetworkError.badURL)
    }

    do {
        let (data, response) = try await URLSession.shared.data(from: url)

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            return .failure(NetworkError.unknown)
        }

        let users = try JSONDecoder().decode([User].self, from: data)
        return .success(users)
    } catch {
        return .failure(error)
    }
}

enum NetworkError: Error {
    case badURL
    case decodingFailed
    case noData
    case unknown
}

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
}

Task {
    let result = await fetchData()

    switch result {
    case .success(let users):
        users.forEach { print("• \($0.email)") }
    case .failure(let error):
        print("Failed to fetch users:", error)
    }

    exit(0)
}

RunLoop.main.run()
