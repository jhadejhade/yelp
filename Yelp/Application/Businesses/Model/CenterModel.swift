//
//  Center.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

class CenterModel : Codable {
    
    let latitude : Float?
    let longitude : Float?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }
}
