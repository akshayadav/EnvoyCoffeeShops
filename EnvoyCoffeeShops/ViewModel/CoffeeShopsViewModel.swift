//
//  CoffeeShopsViewModel.swift
//  EnvoyCoffeeShops
//
//  Created by Akshay Yadav on 2/23/25.
//

import SwiftUI
import OSLog

@Observable
public class CoffeeShopsViewModel {
    
    private let logger = Logger(subsystem: "com.example.EnvoyCoffeeShops", category: "CoffeeShopsViewModel")

    private let networkManager = NetworkManager.shared
    private let authenticationManager = AuthenticationManager.shared
    
    private var offset = 0
    
    public var coffeeShops: [CoffeeShop] = []
    
    private func fetchCoffeeShops() async {
        let header = authenticationManager.getAuthorizationHeader()
        do {
            let newData: [CoffeeShop] = try await networkManager.fetchCoffeeShops(
                header: header,
                url: authenticationManager.getURL(),
                limit: "10",
                offset: "\(offset)"
            )
            coffeeShops = coffeeShops + newData
        } catch {
            logger.error("Unable to fetch data with error: \(error.localizedDescription)")
            print("Error fetching data: \(error)")
        }
    }
    
    public func loadMore() async {
        if coffeeShops.isEmpty {
            offset = 0
        } else {
            offset += 10
        }
        await fetchCoffeeShops()
    }
}
