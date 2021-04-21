//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import UIKit
import Cosmos
import Kingfisher

class BusinessTableViewCell: UITableViewCell, BusinessElementCell {
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var businessRatingsView: CosmosView!
    @IBOutlet private var businessContactLabel: UILabel!
    @IBOutlet private var businessPriceLabel: UILabel!
    @IBOutlet private var businessNameLabel: UILabel!
    @IBOutlet private var businessImage: UIImageView!
    @IBOutlet private var distanceLabel: UILabel!
    
    func configure(model: BusinessElementModel) {
        guard let businessModel = model as? BusinessModel else {
            print("error casting model as User: \(model)")
            return
        }
        
        containerView.makeElevation(elevation: 5)
        businessNameLabel.text = businessModel.name
        businessContactLabel.text = businessModel.phone ?? "Contact not available"
        businessPriceLabel.text = businessModel.price ?? "Price Not available"
        businessRatingsView.rating = Double(businessModel.rating ?? 0)
        distanceLabel.text = "\(Int(businessModel.distance ?? 0))m"
        
        guard let imageUrl = businessModel.imageUrl else {
            return
        }
        
        businessImage.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: { (progress, content) in
            
        }) { (result) in
            
        }
    }
}
