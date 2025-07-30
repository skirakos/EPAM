//
//  APIService.swift
//  UnitTesting
//

import Foundation

final class APIService: APIServiceProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func fetchUsers(
        urlString: String,
        completion: @escaping (Result<[User], APIError>) -> Void)
    {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(.unexpected))
                return
            }
            guard let data = data else {
                completion(.failure(.unexpected))
                return
            }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(.parsingError))
            }
        }.resume()
    }

    func fetchUsersAsync(
        urlString: String
    ) async -> Result<[User], APIError> {
        await withCheckedContinuation { continuation in
            fetchUsers(urlString: urlString) { result in
                continuation.resume(returning: result)
            }
        }
    }
}
