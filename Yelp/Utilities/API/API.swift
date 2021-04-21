//
//  API.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

enum BaseUrl: String {
    case prod = "api.yelp.com"
}

struct API {

    typealias Parameters = [String: Any]
    var path: String
    var queryItems: [URLQueryItem]
    var urlType: BaseUrl
    var method: HTTPMethod

    init(path: AppEndpoints, queryParams: Parameters = [:], urlType: BaseUrl = .prod) {
        self.path = path.path
        self.queryItems = queryParams.toURLQueryItem()
        self.urlType = urlType
        self.method = path.method
    }
}
