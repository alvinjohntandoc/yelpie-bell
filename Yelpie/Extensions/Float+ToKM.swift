//
//  Float+ToKM.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation

extension Float {
    var toKm: String {
        return String(format: "%.2f KM Away", (self / 1000))
    }
}
