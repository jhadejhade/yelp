//
//  Location.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

class LocationModel : Codable {
    
    let address1 : String?
    let address2 : String?
    let address3 : String?
    let city : String?
    let country : String?
    let state : String?
    let zipCode : String?
    
    enum CodingKeys: String, CodingKey {
        case address1 = "address1"
        case address2 = "address2"
        case address3 = "address3"
        case city = "city"
        case country = "country"
        case state = "state"
        case zipCode = "zip_code"
    }
}
