//
//  Business.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

class BusinessModel : Codable, BusinessElementModel {
    
    let alias : String?
    let categories : [CategoryModel]?
    let coordinates : CoordinateModel?
    let distance : Float?
    let id : String?
    let imageUrl : String?
    let isClosed : Bool?
    let location : LocationModel?
    let name : String?
    let phone : String?
    let price : String?
    let rating : Double?
    let reviewCount : Int?
    let transactions : [String]
    let url : String?
    let hours : [HourModel]?
    let isClaimed : Bool?
    
    var cellType: BusinessElementType = .businessCell
    
    enum CodingKeys: String, CodingKey {
        case alias = "alias"
        case categories = "categories"
        case coordinates = "coordinates"
        case distance = "distance"
        case id = "id"
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case location = "location"
        case name = "name"
        case phone = "phone"
        case price = "price"
        case rating = "rating"
        case reviewCount = "review_count"
        case transactions = "transactions"
        case url = "url"
        case hours = "hours"
        case isClaimed = "is_claimed"
    }
}
