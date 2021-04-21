//
//  YelpRequestManagerProtocol.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation
import Combine

protocol YelpRequestManagerProtocol {
    func getLocalBusinesses(location: String) -> AnyPublisher<BusinessResultModel, ApiError>
    func getBusinessDetails(id: String) -> AnyPublisher<BusinessModel, ApiError>
}
