//
//  DesignableXibView.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation
import UIKit

open class DesignableXibView: UIView {

    public var contentView: UIView?

    // MARK: - Life cycle

    convenience public init() {
        self.init(frame: CGRect.zero)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setup()
    }

    open var bundle: Bundle? {
        return Bundle(for: type(of: self))
    }

    /// This is provided as a convenience method to facilitate additional customization of instances during initialization
    /// You must call the super implementation of setup to give parent classes the opportunity to perform any additional initialization they require.
    open func setup() {
        backgroundColor = .clear
    }

    private func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }

    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "\(type(of: self).self)", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
