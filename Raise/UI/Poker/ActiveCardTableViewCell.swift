//
//  ActiveCardTableViewCell.swift
//  Raise
//
//  Created by Stephen Hayes on 3/5/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit

class ActiveCardTableViewCell: UITableViewCell {

    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!

    func setUp(with activeCard: ActiveCard) {
        if let firstInitial = activeCard.player.name.first {
            initialLabel.text = String(firstInitial)
        } else {
            initialLabel.text = nil
        }

        nameLabel.text = activeCard.player.name
        cardImageView.image = activeCard.card?.value.image
    }
}
