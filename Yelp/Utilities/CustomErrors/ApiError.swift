//
//  ApiError.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//
import Foundation

enum ApiError: Error {
    case noInternetConnection
    case invalidData
    case requestFailed(error: String)
    case responseUnsuccessful(responseError: String)
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful(let responseError): return responseError
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .noInternetConnection: return "No Internet Connection"
        }
    }
}
