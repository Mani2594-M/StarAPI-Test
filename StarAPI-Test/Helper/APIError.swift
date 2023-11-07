//
//  APIError.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badUrl
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        // Feedback for User
        switch self {
        case .badUrl, .parsing, .unknown:
            return "Something went wrong."
        case .badResponse(_):
            return "Connection to server failed."
        case .url(let error):
            return error?.localizedDescription ?? "Unknown Error."
        }
    }
    
    var description: String {
        // Info for debugging
        switch self {
        case .unknown:
            return "Unknown error."
        case .badUrl:
            return "Invalid URL."
        case .url(let error):
            return error?.localizedDescription ?? "Session Error."
        case .parsing(let error):
            return "Parsing Error \(error?.localizedDescription ?? "")"
        case .badResponse(statusCode: let statusCode):
            return "Bad response with status code \(statusCode)"
        }
    }
}
