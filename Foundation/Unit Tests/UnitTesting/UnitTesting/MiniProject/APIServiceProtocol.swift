//
//  APIServiceProtocol.swift
//  UnitTesting
//

import Foundation

protocol APIServiceProtocol {
    func fetchUsers(
        urlString: String,
        completion: @escaping (Result<[User], APIError>) -> Void
    )
    func fetchUsersAsync(
        urlString: String
    ) async -> Result<[User], APIError>
}
