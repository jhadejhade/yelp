//
//  RequestManagerProtocol.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation
import Combine

protocol RequestManagerProtocol {
    typealias Headers = [String: Any]
    typealias Parameters = [String: Any]
    typealias ArrayParamenters = [[String: Any]]
    
    func request<T>(type: T.Type, api: API, headers: Headers, jsonBody: Parameters, queue: DispatchQueue, retries: Int) -> AnyPublisher<T, ApiError> where T: Decodable
}

extension RequestManagerProtocol {
    func request<T>(type: T.Type, api: API, headers: Headers = [:], jsonBody: Parameters = [:], queue: DispatchQueue = .main, retries: Int = 0) -> AnyPublisher<T, ApiError> where T: Decodable {
        return request(type: type, api: api, headers: headers, jsonBody: jsonBody, queue: queue, retries: retries)
    }
}
