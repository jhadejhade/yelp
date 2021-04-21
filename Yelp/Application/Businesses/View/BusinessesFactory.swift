//
//  BusinessesFactory.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

struct BusinessesFactory {
    
    static func makeBusinessViewController() -> BusinessesViewController {
        let businessesViewController = BusinessesViewController.instantiateFromStoryboard()
        businessesViewController.viewModel = BusinessesViewModel(requestManager: YelpRequestManager.shared, locationManager: LocationManager())
        return businessesViewController
    }
}
