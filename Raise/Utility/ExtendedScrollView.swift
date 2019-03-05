//
//  ExtendedScrollView.swift
//  Raise
//
//  Created by Stephen Hayes on 3/4/19.
//  Copyright © 2019 Raise Software. All rights reserved.
//

import UIKit

class ExtendedScrollView: UIView {

    @IBOutlet private var scrollView: UIScrollView!

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? scrollView : view
    }
}
