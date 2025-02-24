//
//  AuthenticationManager.swift
//  EnvoyCoffeeShops
//
//  Created by Akshay Yadav on 2/23/25.
//

import Foundation
import OSLog

fileprivate struct AuthenticationKey {
    
    static let apiKey = "" // UPDATE THE API KEY
    
    static let url = "https://api.yelp.com/v3/businesses/search"
}

public class AuthenticationManager {

    private let logger = Logger(subsystem: "com.example.EnvoyCoffeeShops", category: "AuthenticationManager")

    public static let shared = AuthenticationManager()
    
    public func getAuthorizationHeader() -> [String: String] {
        return [
            "accept": "application/json",
            "authorization": "Bearer \(AuthenticationKey.apiKey)"
        ]
    }
    
    public func getURL() throws -> URL {
        guard let url = URL(string: AuthenticationKey.url) else {
            logger.error("Failed to generate URL from \(AuthenticationKey.url)")
            throw NetworkingError.invalidURL
        }
        return url
    }
}
