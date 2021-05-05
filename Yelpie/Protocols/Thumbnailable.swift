//
//  Thumbnailable.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation

protocol Thumbnailable {
    var name: String { get }
    var compactLocation: String { get }
    var rating: Float { get }
    var distance: Float? { get }
    var imageURL: String { get }
}

typealias Thumbnailables = [Thumbnailable]
