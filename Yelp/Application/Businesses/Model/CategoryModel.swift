//
//  Category.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

class CategoryModel : Codable {
    
    let alias : String?
    let title : String?
    
    enum CodingKeys: String, CodingKey {
        case alias = "alias"
        case title = "title"
    }
}

