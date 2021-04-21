//
//  AddressTableViewCell.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import UIKit

class AddressTableViewCell: UITableViewCell, BusinessElementCell {

    private struct Constants {
        static let addressFormat = "%@ %@ %@, %@, %@, %@, %@"
    }
    
    @IBOutlet private var addressLabel: UILabel!
    
    func configure(model: BusinessElementModel) {
        guard let businessModel = model as? BusinessModel else {
            print("error casting model as User: \(model)")
            return
        }
        
        addressLabel.text = String(format: Constants.addressFormat, businessModel.location?.address1 ?? "", businessModel.location?.address2 ?? "", businessModel.location?.address3 ?? "", businessModel.location?.city ?? "", businessModel.location?.state ?? "", businessModel.location?.zipCode ?? "", businessModel.location?.country ?? "" )
    }
    
}
