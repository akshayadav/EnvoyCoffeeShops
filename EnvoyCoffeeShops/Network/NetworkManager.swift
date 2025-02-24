//
//  NetworkManager.swift
//  EnvoyCoffeeShops
//
//  Created by Akshay Yadav on 2/23/25.
//

import Foundation
import OSLog

public struct URLComponentConstant {
    static let location = "location"
    static let address = "410 Townsend Street, San Francisco, CA"
    static let categories = "categories"
    static let coffeeshops = "Coffeeshops"
    static let sortBy = "sort_by"
    static let rating = "rating"
    static let limit = "limit"
    static let offset = "offset"
}

enum NetworkingError: Error {
    case invalidURL
    case invalidURLComponents
    case decodingFailed
    case urlSessionFailed
}

public class NetworkManager {
    
    public static let shared = NetworkManager()
    
    private let logger = Logger(subsystem: "com.example.EnvoyCoffeeShops", category: "NetworkManager")
    
    private init() {}
    
    public func fetchCoffeeShops(
        header: [String: String],
        url: URL, limit: String,
        offset: String
    ) async throws -> [CoffeeShop] {

        guard let baseComponents = URLComponents(
            url: url,
            resolvingAgainstBaseURL: true
        ) else {
            logger.error("Unable to get base URL components")
            throw NetworkingError.invalidURLComponents
        }
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: URLComponentConstant.location, value: URLComponentConstant.address),
            URLQueryItem(name: URLComponentConstant.categories, value: URLComponentConstant.coffeeshops),
            URLQueryItem(name: URLComponentConstant.sortBy, value: URLComponentConstant.rating),
            URLQueryItem(name: URLComponentConstant.limit, value: limit),
            URLQueryItem(name: URLComponentConstant.offset, value: offset)
        ]
        var components = baseComponents
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        guard let componentsURL = components.url else {
            logger.error("Unable to get base URL components")
            throw NetworkingError.invalidURLComponents
        }
        var request = URLRequest(url: componentsURL)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = header
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let yelpResponse = try JSONDecoder().decode(YelpResponse.self, from: data)
            return yelpResponse.businesses
        } catch {
            logger.error("Unable to fetch data with error: \(error.localizedDescription)")
            throw error
        }
    }
}
