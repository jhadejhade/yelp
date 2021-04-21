//
//  API+URL.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

extension API {

    private struct K {
        static let scheme = "https"
        static let invalidURL = "Invalid URL Components: %@"
    }

    var url: URL {
        var components = URLComponents()
        components.scheme = K.scheme
        components.host = urlType.rawValue
        components.path = path
        components.queryItems = queryItems.count == 0 ? [] : queryItems

        guard let url = components.url else {
            preconditionFailure(String(format: K.invalidURL, components.description))
        }

        return url
    }

    var headers: [String: Any] {
        // Add Common Headers here
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer 8Ez7hIjxCejmTEMd-6icDg_BklKSN6UInvhc1NWau_nIt1V2gXnwlY-Rp6Q7-heu2EXz5sdH-CCDisJjrTIWloyt9PyNt4r43tOnTd-baa_WA9Jr5mjWDc5j-rN_YHYx"]
    }
}
