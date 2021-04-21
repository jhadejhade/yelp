//
//  ScheduleTableViewCell.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import UIKit
import TagListView

class ScheduleTableViewCell: UITableViewCell, BusinessElementCell {

    @IBOutlet private var tagsListView: TagListView!
    @IBOutlet private var headerLabel: UILabel!
    
    private let days: [Int: String] = [0: "Monday", 1: "Tuesday", 2: "Wednesday", 3: "Thursday", 4: "Friday", 5: "Saturday", 6: "Sunday", -1 : "Not available"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(model: BusinessElementModel) {
        guard let openModel = model as? OpenModel else {
            print("error casting model as User: \(model)")
            return
        }
        
        tagsListView.removeAllTags()
        tagsListView.textFont = UIFont.systemFont(ofSize: 17)
        headerLabel.text = days[openModel.day ?? -1]
        tagsListView.addTag(String(format: "%@ - %@", (openModel.start ?? "").unfoldSubSequences(limitedTo: 2).joined(separator: ":"), (openModel.end ?? "").unfoldSubSequences(limitedTo: 2).joined(separator: ":")))
    }
}
