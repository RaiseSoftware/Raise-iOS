//
//  ActiveCardTableViewCell.swift
//  Raise
//
//  Created by Stephen Hayes on 3/5/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit

class ActiveCardTableViewCell: UITableViewCell {

    @IBOutlet private var initialLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var cardImageView: UIImageView!

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
