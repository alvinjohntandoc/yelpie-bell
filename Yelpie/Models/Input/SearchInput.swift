//
//  SearchInput.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation

struct SearchInput: Codable {
    let term: String
    let latitude: Double
    let longitude: Double
    let sortBy: Sort
    
    enum CodingKeys: String, CodingKey {
        case term
        case latitude
        case longitude
        case sortBy = "sort_by"
    }
}
