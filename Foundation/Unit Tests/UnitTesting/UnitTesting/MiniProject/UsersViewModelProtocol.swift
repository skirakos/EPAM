//
//  UsersViewModelProtocol.swift
//  UnitTesting
//

protocol UsersViewModelProtocol {
    var users: [User] { get }
    var errorMessage: String? { get }

    func fetchUsers(completion: @escaping () -> Void)
    func clearUsers()
}
