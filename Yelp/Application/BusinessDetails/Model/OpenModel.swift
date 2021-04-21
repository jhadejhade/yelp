//
//  OpenModel.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//
import Foundation

class OpenModel : Codable, BusinessElementModel {
    
    let day : Int?
    let end : String?
    let isOvernight : Bool?
    let start : String?
    
    var cellType: BusinessElementType = .scheduleCell
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
        case end = "end"
        case isOvernight = "is_overnight"
        case start = "start"
    }
}
