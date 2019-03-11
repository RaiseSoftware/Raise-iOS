//
//  ExtendedScrollView.swift
//  Raise
//
//  Created by Stephen Hayes on 3/11/19.
//  Copyright © 2019 Raise Software. All rights reserved.
//

import UIKit

class ExtendedScrollView: UIScrollView {

    // Scroll view has 20 padding on each side so that paging behaves with a preview
    // This hit test allows the scroll view to still receive swipe events
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if bounds.inset(by: UIEdgeInsets(top: 0, left: -20, bottom: 0, right: -20)).contains(point) {
            if let view = super.hitTest(point, with: event) {
                return view
            }
            return self
        }
        return nil
    }
}
