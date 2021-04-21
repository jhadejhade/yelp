//
//  YelpRequestManager.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation
import Combine

class YelpRequestManager: YelpRequestManagerProtocol {
    
    static let shared = YelpRequestManager()

    private var requestManager: RequestManagerProtocol

    private init() {
        self.requestManager = RequestManager()
    }

    func getLocalBusinesses(location: String) -> AnyPublisher<BusinessResultModel, ApiError> {
        let api = API(path: .getBusinesses, queryParams: ["location": location])
        
        return requestManager.request(type: BusinessResultModel.self, api: api)
    }
    
    func getBusinessDetails(id: String) -> AnyPublisher<BusinessModel, ApiError> {
        let api = API(path: .getBusinessDetails(id: id))
        
        return requestManager.request(type: BusinessModel.self, api: api)
    }
}
