//
//  BusinessDetailsFactory.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

struct BusinessDetailsFactory {
    
    static func makeBusinessDetails(id: String) -> BusinessDetailsViewController {
        let viewController = BusinessDetailsViewController.instantiateFromStoryboard()
        viewController.viewModel = BusinessDetailsViewModel(id: id, requestManager: YelpRequestManager.shared)
        return viewController
    }
}
