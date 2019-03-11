//
//  RoundedFilledButton.swift
//  Raise
//
//  Created by Stephen Hayes on 3/3/19.
//  Copyright © 2019 Raise Software. All rights reserved.
//

import UIKit

class RoundedFilledButton: UIButton {

    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? self.tintColor : .clear
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        clipsToBounds = true

        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2.0
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = frame.width / 2
    }
}
