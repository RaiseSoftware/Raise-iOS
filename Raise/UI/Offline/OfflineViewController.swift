//
//  OfflineViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 3/3/19.
//  Copyright © 2019 Raise Software. All rights reserved.
//

import UIKit

class OfflineViewController: HomeItemViewController {

    @IBOutlet private var deckTypeSegmentedControl: UISegmentedControl!

    @IBAction private func startPressed() {
        if let pokerVC = UIStoryboard(name: "Poker", bundle: nil).instantiateInitialViewController() as? PokerViewController {
            pokerVC.isOffline = true
            pokerVC.deck = deckTypeSegmentedControl.selectedSegmentIndex == 0 ? .fibonacci : .tshirt

            present(pokerVC, animated: true) {
                self.delegate?.closePressed(self)
            }
        }
    }
}
