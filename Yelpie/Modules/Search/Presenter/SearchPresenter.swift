//
//  SearchPresenter.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation
import CoreLocation
import Moya

protocol SearchViewPresenterDelegate: AnyObject {
    /// Will return array of Business object returned by yelp api
    func presentThumbnailables(thumbnailables: Thumbnailables)
    
    /// Will present business object from a thumbnailable protocol
    func presentBusiness(business: Business)
    
    /// Will present sorting options
    func presentSortOptions(options: [Sort])
}

class SearchViewPresenter {
    
    //MARK: - Services
    private let apiService = SearchAPIService()
    
    //MARK: - Properties
    private weak var delegate: SearchViewPresenterDelegate?
    private var myLocation: CLLocationCoordinate2D?
    
    private var cancellable: Cancellable?
    
    // MARK: - Services
    private let locationService = LocationService()
    
    init(delegate: SearchViewPresenterDelegate) {
        self.delegate = delegate
        
        locationService.startTracking()
        handleTracker()
    }
    
    /// start tracking your location
    func startLocationTracking() {
        locationService.startTracking()
    }
    
    private func handleTracker() {
        locationService.coordinate = { [weak self] coordinate in
            guard let self = self else {
                return
            }
            
            self.myLocation = coordinate
        }
    }
    
    /// Will hit yelp fusion api
    /// from the given keyword and coordinate
    ///
    /// - Parameters:
    ///     - keyword: name, cusisine or address
    ///     - sort: The arrangement of the list
    func search(keyword: String, sort: Sort) {
        guard let myLocation = myLocation else {
            print("Please enable your location.")
            return
        }
        
        let input = SearchInput(term: keyword,
                                latitude: myLocation.latitude,
                                longitude: myLocation.longitude,
                                sortBy: sort)
        
        cancellable?.cancel()
        cancellable = apiService.request(.search(input: input),
                    target: SearchResponse.self) { [weak self] (response) in
            guard let self = self else { return }
            self.delegate?.presentThumbnailables(thumbnailables: response.businesses)
        }
    }
    
    /// Convert thumbnailable to concrete data type
    func convertAndPresentThumbnailable(_ thumbnailable: Thumbnailable) {
        guard let object = thumbnailable as? Business else { return }
        delegate?.presentBusiness(business: object)
    }
    
    /// Will Create sorting options
    func createSortingOptions() {
        let options = Sort.allCases
        delegate?.presentSortOptions(options: options)
        
    }
}


