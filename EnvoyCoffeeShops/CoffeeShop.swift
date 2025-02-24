//
//  CoffeeShop.swift
//  EnvoyCoffeeShops
//
//  Created by Akshay Yadav on 2/24/25.
//

import Foundation

public struct CoffeeShop: Codable, Identifiable {
    public let id: String
    let alias : String?
    let name: String
    let image_url: String?
    let url: String?
    let price: String?
    let location: Location?
    let phone: String?
    let distance: Double?
    
    func distanceString() -> String? {
        if let distance = distance {
            return String(format: "%.1f miles", distance * 0.000621371)
        }
        return nil
    }
    
    func websiteURL() -> URL? {
        guard
            let urlString = url,
            let websiteURL = URL(string: urlString) else {
                return nil
        }
        return websiteURL
    }
    
    func imageURL() -> URL? {
        guard let imageUrlString = image_url,
              let imageURL = URL(string: imageUrlString) else {
            return nil
        }
        return imageURL
    }
}
