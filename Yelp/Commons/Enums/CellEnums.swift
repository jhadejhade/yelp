//
//  CellEnums.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation

public enum BusinessElementType: String {
    case businessCell
    case detailsCell
    case addressCell
    case transactionCell
    case scheduleCell
}

protocol BusinessElementModel: class {
    var cellType: BusinessElementType { get set}
}

protocol BusinessElementCell: class {
    func configure(model: BusinessElementModel)
}
