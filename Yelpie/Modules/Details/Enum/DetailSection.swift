//
//  DetailSection.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation

enum DetailSection {
    case info(items: [DetailsItem])
    case review(items: [DetailsItem])
}

enum DetailsItem {
    case basic(business: Business)
    case titleAndValue(title: String, value: String)
    case review(item: Review)
}
