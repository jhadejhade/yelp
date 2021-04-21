//
//  BusinessViewModel.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation
import Combine
import CoreLocation

protocol BusinessViewModelDelegate: class {
    func didUpdateLocation(placemark: CLPlacemark?, error: LocationError?)
}
class BusinessesViewModel {
    
    enum SortType: String {
        case ratingsAscending
        case distanceAscending
        case distanceDescending
        case ratingsDescending
    }
    
    private(set) var lastLocation: String = ""
    private(set) var businesses: [BusinessModel] = []
    private var originalBusinessList: [BusinessModel] = []
    private var requestManager: YelpRequestManagerProtocol
    private var cancellables: Set<AnyCancellable> = []
    private var locationManager: LocationManager!
    
    weak var delegate: BusinessViewModelDelegate?
    
    init(requestManager: YelpRequestManager, locationManager: LocationManager) {
        self.requestManager = requestManager
        self.locationManager = locationManager
        self.locationManager.delegate = self
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func fetchBusinesses(location: String?, completion: @escaping () -> (), failure: @escaping (String) -> ()) {
        // prevent from calling the api again if user is still around the vicinity of the last location
        guard lastLocation != location else {
            return
        }
        
        requestManager.getLocalBusinesses(location: location ?? "Philippines").sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                failure("Something went wrong. Please try again.")
            case .finished:
                break
            }
        }, receiveValue: { [weak self] result in
            self?.businesses = result.businesses ?? []
            self?.originalBusinessList = result.businesses ?? []
            completion()
        }).store(in: &cancellables)
    }
    
    func search(searchString: String, completion: @escaping () -> ()) {
        guard !searchString.isEmpty else {
            businesses = originalBusinessList
            completion()
            return
        }
        
        let result = originalBusinessList.filter { (model) -> Bool in
            
            let hasCategoryResult = (model.categories ?? []).contains(where: { (model) -> Bool in
                return (model.alias ?? "").lowercased().contains(searchString) || (model.title ?? "").lowercased().contains(searchString)
            })
            
            if (model.name ?? "").lowercased().contains(searchString)
                || hasCategoryResult
                || (model.location?.address1 ?? "").lowercased().contains(searchString)
                || (model.location?.address2 ?? "").lowercased().contains(searchString)
                || (model.location?.address3 ?? "").lowercased().contains(searchString)
                || (model.location?.city ?? "").lowercased().contains(searchString)
                || (model.location?.zipCode ?? "").lowercased().contains(searchString) {
                return true
            } else {
                return false
            }
        }
        
        businesses = result
        completion()
    }
    
    func sort(by sortType: SortType, completion: @escaping () -> ()) {
        switch sortType {
        case .distanceAscending:
            businesses.sort { ($0.distance ?? 0) < ($1.distance ?? 0) }
        case .distanceDescending:
            businesses.sort { ($0.distance ?? 0) > ($1.distance ?? 0) }
        case .ratingsAscending:
            businesses.sort { ($0.rating ?? 0) < ($1.rating ?? 0) }
        case .ratingsDescending:
            businesses.sort { ($0.rating ?? 0) > ($1.rating ?? 0) }
        }
        
        completion()
    }
}

extension BusinessesViewModel: LocationManagerDelegate {
    
    func didUpdateLocation(placemark: CLPlacemark?, error: LocationError?) {
        delegate?.didUpdateLocation(placemark: placemark, error: error)
    }
}
