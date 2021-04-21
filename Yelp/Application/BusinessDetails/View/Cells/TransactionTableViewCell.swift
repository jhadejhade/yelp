//
//  TransactionTableViewCell.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import UIKit
import TagListView

class TransactionTableViewCell: UITableViewCell, BusinessElementCell {

    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var tagsListView: TagListView!
    
    func configure(model: BusinessElementModel) {
        guard let businessModel = model as? BusinessModel else {
            print("error casting model as User: \(model)")
            return
        }
        
        tagsListView.removeAllTags()
        headerLabel.text = "Deals"
        tagsListView.textFont = UIFont.systemFont(ofSize: 17)
        tagsListView.addTags(businessModel.transactions.isEmpty ? ["No Available Data"] : businessModel.transactions)
    }
}
