//
//  String+Capitalize.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/4/21.
//

import Foundation

extension String {
    var capitalizeFirstLetter: String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
