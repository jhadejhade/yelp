//
//  Region.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

class RegionModel : Codable {
    
    let center : CenterModel?
    
    enum CodingKeys: String, CodingKey {
        case center = "center"
    }
}
