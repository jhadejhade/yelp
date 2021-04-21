//
//  RequestManager.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation
import Combine

class RequestManager: RequestManagerProtocol {
    func request<T>(type: T.Type, api: API, headers: Headers, jsonBody: Parameters, queue: DispatchQueue, retries: Int) -> AnyPublisher<T, ApiError> where T : Decodable {
        guard NetworkMonitor.shared.isReachable || NetworkMonitor.shared.isReachableOnCellular else {
            return AnyPublisher(Fail<T, ApiError>(error: ApiError.noInternetConnection))
        }

        var urlRequest = URLRequest(url: api.url)

        let newHeaders = api.headers.merging(headers) {(current, _) in current}

        urlRequest.httpMethod = api.method.rawValue.uppercased()
        newHeaders.forEach { (key, value) in
            guard let value = value as? String else {
                return
            }

            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        if api.method != .get {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: jsonBody, options: .prettyPrinted)
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw ApiError.responseUnsuccessful(responseError: String(decoding: $0.data, as: UTF8.self))
                }

                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ (error) -> ApiError in
                switch error {
                case is Swift.DecodingError:
                    return ApiError.jsonParsingFailure
                case let urlError as URLError:
                    return ApiError.requestFailed(error: urlError.localizedDescription)
                case let apiError as ApiError:
                    return apiError
                default:
                    return ApiError.requestFailed(error: error.localizedDescription)
                }
            })
            .receive(on: queue)
            .retry(retries)
            .eraseToAnyPublisher()
    }
}
