//
//  Location.swift
//  EnvoyCoffeeShops
//
//  Created by Akshay Yadav on 2/24/25.
//

public struct Location: Codable {
    let address1: String?
    let address2: String?
    let address3: String?
    let city: String?
    let zip_code: String?
    let country: String?
    let state: String?
    let display_address: [String]?
}
