//
//  DashboardPresenter.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/4/21.
//

import Foundation
import UIKit

protocol DashboardPresenterDelegate: AnyObject {
    func presentCompactLocation(location: String)
}

class DashboardPresenter {
    
    //MARK: - Services
    private let locationService = LocationService()
    
    //MARK: - Properties
    private weak var delegate: DashboardPresenterDelegate?
    
    init(delegate: DashboardPresenterDelegate) {
        self.delegate = delegate
    }
    
    /// Start tracking location
    func trackLocation() {
        locationService
            .startTracking()
     
        locationService.currentLocationAddress = { [weak self] location in
            guard let self = self,
                  let location = location else {
                return
            }
            
            self.delegate?.presentCompactLocation(location: location)
        }
    }
}

