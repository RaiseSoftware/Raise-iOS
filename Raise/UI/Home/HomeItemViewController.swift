//
//  HomeItemViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 3/5/19.
//  Copyright © 2019 Raise Software. All rights reserved.
//

import UIKit

protocol HomeItemDelegate: AnyObject {

    func closePressed(_ controller: HomeItemViewController)
}

class HomeItemViewController: UIViewController {

    @IBOutlet private var closeButton: UIButton!

    weak var delegate: HomeItemDelegate?

    func updateCloseButtonVisibility(alpha: CGFloat) {
        closeButton.alpha = alpha
    }

    @IBAction private func closeButtonPressed() {
        delegate?.closePressed(self)
    }
}
