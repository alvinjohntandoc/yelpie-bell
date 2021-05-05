//
//  DCategoryViewPresenter.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation
import CoreLocation

protocol DCategoryViewPresenterDelegate: AnyObject {
    /// Will return array of Business object returned by yelp api
    func presentThumbnailables(thumbnailables: Thumbnailables)
    
    /// Will present business object from a thumbnailable protocol
    func presentBusiness(business: Business)
    
    /// Will trigger if location is available
    func locationIsAvailable()
}

class DCategoryViewPresenter {
    
    //MARK: - Services
    private let apiService = SearchAPIService()
    private let locationService = LocationService()
    
    //MARK: - Properties
    private weak var delegate: DCategoryViewPresenterDelegate?
    
    private var myLocation: CLLocationCoordinate2D? {
        didSet {
            delegate?.locationIsAvailable()
        }
    }
    
    init(delegate: DCategoryViewPresenterDelegate) {
        self.delegate = delegate

        handleTracker()
    }
    
    private func handleTracker() {
        locationService.coordinate = { [weak self] coordinate in
            guard let self = self else {
                return
            }
            
            self.myLocation = coordinate
        }
    }

    func startLocationTracking() {
        locationService.startTracking()
    }
    
    /// Will hit fusion api and use category as the value of term
    /// Returns business with highest rating
    /// user location is requried
    ///
    /// - Parameters:
    ///    - category: [restaurants, coffee-shops, malss]
    func search(category: BestCategory) {
        guard let myLocation = myLocation else {
            return
        }
        
        let input = SearchInput(term: category.rawValue,
                                latitude: myLocation.latitude,
                                longitude: myLocation.longitude, sortBy: .rating)
        
        apiService.request(.search(input: input),
                    target: SearchResponse.self) { [weak self] (response) in
            guard let self = self else { return }
            self.delegate?.presentThumbnailables(thumbnailables: response.businesses)
        }
    }
    
    /// convert protocol to concrete type
    func convertAndPresentThumbnailable(_ thumbnailable: Thumbnailable) {
        guard let object = thumbnailable as? Business else { return }
        delegate?.presentBusiness(business: object)
    }
}

