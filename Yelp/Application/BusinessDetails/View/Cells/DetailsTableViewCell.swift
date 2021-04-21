//
//  DetailsTableViewCell.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import UIKit
import TagListView

class DetailsTableViewCell: UITableViewCell, BusinessElementCell {

    @IBOutlet var tagListView: TagListView!
    @IBOutlet var businessNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var contactNumberLabel: UILabel!
    
    func configure(model: BusinessElementModel) {
        guard let businessModel = model as? BusinessModel else {
            print("error casting model as User: \(model)")
            return
        }
        
        businessNameLabel.text = businessModel.name
        priceLabel.text = businessModel.price ?? "Price Not available"
        
        if let phone = businessModel.phone, !phone.isEmpty {
            contactNumberLabel.text = businessModel.phone
        } else {
            contactNumberLabel.text = "Contact not available"
        }
         
        tagListView.removeAllTags()
        
        if let categories = businessModel.categories {
            let titles = categories.map({ $0.title ?? "" })
            tagListView.textFont = UIFont.systemFont(ofSize: 17)
            tagListView.addTags(titles)
        }
    }
}
