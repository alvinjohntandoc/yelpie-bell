//
//  String+Date.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation
import UIKit

extension String {
    var as12HourFormat: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
        
        guard let date = dateFormatter.date(from: self) else { return nil }

        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
}
