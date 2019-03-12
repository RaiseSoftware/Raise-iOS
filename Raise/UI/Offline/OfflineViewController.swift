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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pokerViewController = segue.destination as? PokerViewController {
            pokerViewController.isOffline = true
            pokerViewController.deck = deckTypeSegmentedControl.selectedSegmentIndex == 0 ? .fibonacci : .tshirt
        }
    }
}
