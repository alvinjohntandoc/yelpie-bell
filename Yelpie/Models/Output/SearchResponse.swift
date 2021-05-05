//
//  SearchResponse.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let businesses: [Business]
    let total: Int
    let region: Region
}

// MARK: - Business
struct Business: Codable {
    let id, alias, name: String
    let imageURL: String
    let isClosed: Bool
    let url: String
    let reviewCount: Int
    let categories: [Category]
    let rating: Float
    let location: Location
    let phone, displayPhone: String
    var distance: Float?
    let price: String?
    let hours: [Hour]?
    
    // we will inject this later
    var reviews: [Review]?

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories, rating, location, phone
        case displayPhone = "display_phone"
        case distance, price
        case hours
    }
}

extension Business: Thumbnailable {
    var compactLocation: String {
        if let address = location.address3 {
            return "\(location.address1 ?? "") \(location.address2 ?? "") \(address)"
        } else {
            return "\(location.address1 ?? "") \(location.address2 ?? "")"
        }
    }
}

// MARK: - Category
struct Category: Codable {
    let alias, title: String
}

// MARK: - Center
struct Center: Codable {
    let latitude, longitude: Double
}

// MARK: - Location
struct Location: Codable {
    let address1, address2: String?
    let address3: String?
    let displayAddress: [String]

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3
        case displayAddress = "display_address"
    }
}

// MARK: - Region
struct Region: Codable {
    let center: Center
}

// MARK: - Hour
struct Hour: Codable {
    let hourOpen: [Open]
    let hoursType: String
    let isOpenNow: Bool

    enum CodingKeys: String, CodingKey {
        case hourOpen = "open"
        case hoursType = "hours_type"
        case isOpenNow = "is_open_now"
    }
}

// MARK: - Open
struct Open: Codable {
    let isOvernight: Bool
    let start, end: String
    let day: Day

    enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start, end, day
    }
}

enum Day: Int, Codable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var word: String {
        switch self {
        case .sunday:
            return "Sunday"
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        }
    }
    
}
