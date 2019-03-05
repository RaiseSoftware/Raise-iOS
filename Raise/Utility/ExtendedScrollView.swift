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
        return self.point(inside: point, with: event) ? scrollView : nil
    }
}
