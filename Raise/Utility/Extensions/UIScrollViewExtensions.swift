//
//  UIScrollViewExtensions.swift
//  Raise
//
//  Created by Stephen Hayes on 3/3/19.
//  Copyright © 2019 Raise Software. All rights reserved.
//

import UIKit

extension UIScrollView {

    func scrollToPage(page: Int, animated: Bool = true) {
        var frame = self.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        scrollRectToVisible(frame, animated: animated)
    }
}
