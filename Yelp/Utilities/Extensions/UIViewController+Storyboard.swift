//
//  UIViewController+Storyboard.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import UIKit
import Foundation

public protocol StoryboardInstantiable: class {
    static var storyboardName: String { get }
    static var storyboardID: String? { get }
}

public extension StoryboardInstantiable where Self: UIViewController {

    static func instantiateFromStoryboard(bundle: Bundle? = nil) -> Self {
        let storyboardViewController: UIViewController?

        if let storyboardID = storyboardID {
            storyboardViewController = UIStoryboard(name: storyboardName, bundle: bundle).instantiateViewController(withIdentifier: storyboardID)
        } else {
            storyboardViewController = UIStoryboard(name: storyboardName, bundle: bundle).instantiateInitialViewController()
        }

        guard let viewController = storyboardViewController as? Self else {
            fatalError("Could not instantiate from storyboard for class name: '\(String(describing: self))'")
        }

        return viewController
    }

}

extension UIViewController: StoryboardInstantiable {

    @objc open class var storyboardName: String {
        return String(describing: self).deleteSuffix("ViewController")
    }

    @objc open class var storyboardID: String? {
        return nil
    }

}

extension String {
    public func deleteSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else {
            return self
        }

        return String(dropLast(suffix.count))
    }
}
