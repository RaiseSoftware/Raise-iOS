//
//  PokerPlayerTableViewCell.swift
//  Raise
//
//  Created by Stephen Hayes on 3/5/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit

class PokerPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    func setUp(with player: Player) {
        if let firstInitial = player.name.first {
            initialLabel.text = String(firstInitial)
        } else {
            initialLabel.text = nil
        }

        nameLabel.text = player.name
    }
}
