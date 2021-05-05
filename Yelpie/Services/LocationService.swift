//
//  LocationService.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/4/21.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    private let locationManager = CLLocationManager()
    
    var coordinate: ((CLLocationCoordinate2D) -> Void)?
    var currentLocationAddress: ((String?) -> Void)?
    
    private var coordinate2d: CLLocationCoordinate2D?
    
    lazy var geocoder = CLGeocoder()
    
    public func startTracking() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        guard let currentCoordinate = coordinate2d else {
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
                locationManager.startUpdatingLocation()
            }
            
            return
        }
        
        coordinate?(currentCoordinate)
        setupLocationName(coordinate2d: currentCoordinate)
    }
    
    public func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
    
    public func myDistanceFromLocation(_ location: CLLocationCoordinate2D) -> String? {
        guard let coordinate2d = coordinate2d else { return nil }
        
        let from = CLLocation(latitude: coordinate2d.latitude, longitude: coordinate2d.longitude)
        let to = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let distance = from.distance(from: to) / 1000
        return String(format: "%.2f KM", distance)
    }
    
    private func setupLocationName(coordinate2d: CLLocationCoordinate2D) {
        // Create Location
        let location = CLLocation(latitude: coordinate2d.latitude,
                                  longitude: coordinate2d.longitude)

        // Geocode Location
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if error == nil {
            if let placemarks = placemarks, let placemark = placemarks.first {
                currentLocationAddress?(placemark.compactAddress)
            }
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        self.coordinate2d = locValue
        coordinate?(locValue)
        setupLocationName(coordinate2d: locValue)
    }
}

extension CLPlacemark {

    var compactAddress: String? {
        if let name = name {
            var result = name

            if let city = locality {
                result += ", \(city)"
            }

            return result
        }

        return nil
    }

}
