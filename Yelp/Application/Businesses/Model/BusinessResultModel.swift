//
//  BusinessResultModel.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

class BusinessResultModel : Codable {
    
    let businesses : [BusinessModel]?
    let region : RegionModel?
    let total : Int?
    
    enum CodingKeys: String, CodingKey {
        case businesses = "businesses"
        case region = "region"
        case total = "total"
    }
}
