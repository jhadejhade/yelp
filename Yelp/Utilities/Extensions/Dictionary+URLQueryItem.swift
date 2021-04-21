//
//  Dictionary+URLQueryItem.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

extension Dictionary {

    func toURLQueryItem() -> [URLQueryItem] {
        return self.map({
            guard let key = $0.key as? String, let value = $0.value as? String else {
                return nil
            }

            return URLQueryItem(name: key, value: value)
        }).compactMap({
            return $0
        })
    }
}
