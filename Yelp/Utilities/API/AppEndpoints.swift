//
//  AppEndpoints.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

enum AppEndpoints {
    
    case getBusinesses
    case getBusinessDetails(id: String)
    
    var path: String {
        switch self {
        case .getBusinesses:
            return "/v3/businesses/search"
        case .getBusinessDetails(let id):
            return "/v3/businesses/" + id
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
}
