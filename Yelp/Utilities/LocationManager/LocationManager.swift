//
//  LocationManager.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    func didUpdateLocation(placemark: CLPlacemark?, error: LocationError?)
}
class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        guard self.locationManager.authorizationStatus != .denied else {
            delegate?.didUpdateLocation(placemark: nil, error: LocationError.denied)
            return
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - Core Location Delegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { [weak self] (placemarks, error) in
            guard let self = self else {
                return
            }
            
            if (error != nil){
                self.delegate?.didUpdateLocation(placemark: nil, error: LocationError.noLocationFound)
            }
            
            guard let placemarks = placemarks else {
                self.delegate?.didUpdateLocation(placemark: nil, error: LocationError.noLocationFound)
                return
            }
            
            guard !placemarks.isEmpty else {
                self.delegate?.didUpdateLocation(placemark: nil, error: LocationError.noLocationFound)
                return
            }
            
            self.delegate?.didUpdateLocation(placemark: placemarks.first, error: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.didUpdateLocation(placemark: nil, error: LocationError.noLocationFound)
    }
}
