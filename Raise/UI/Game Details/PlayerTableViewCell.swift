//
//  PlayerTableViewCell.swift
//  Raise
//
//  Created by Stephen Hayes on 2/21/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet private var initialLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!

    func setUp(with player: Player) {
        if let firstInitial = player.name.first {
            initialLabel.text = String(firstInitial)
        } else {
            initialLabel.text = nil
        }

        nameLabel.text = player.name
    }
}
