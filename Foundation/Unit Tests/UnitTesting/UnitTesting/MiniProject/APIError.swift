//
//  APIError.swift
//  UnitTesting
//

enum APIError: Error, Equatable {
    case invalidUrl
    case parsingError
    case unexpected
}
