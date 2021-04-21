//
//  UIView+Elevation.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import UIKit

extension UIView
{
    func makeElevation(elevation: Double)
    {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = CGFloat(elevation)
    }
}
