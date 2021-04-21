//
//  HourModel.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

class HourModel : Codable {
    
    let hoursType : String?
    let isOpenNow : Bool?
    let open : [OpenModel]?
    
    enum CodingKeys: String, CodingKey {
        case hoursType = "hours_type"
        case isOpenNow = "is_open_now"
        case open = "open"
    }
}
