//
//  GameDetailsViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 2/20/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit

class GameDetailsViewController: UIViewController {

    @IBOutlet weak var gameIDLabel: UILabel!
    @IBOutlet weak var passcodeLabel: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!

    var gameResponse: CreateResponse!

    override func viewDidLoad() {
        super.viewDidLoad()

        gameIDLabel.text = "Game ID: \(gameResponse.pokerGame.gameId)"

        if let passcode = gameResponse.pokerGame.passcode {
            passcodeLabel.isHidden = false
            passcodeLabel.text = "Passcode: \(passcode)"
        } else {
            passcodeLabel.isHidden = true
        }

        if let imageData = Data(base64Encoded: gameResponse.pokerGame.qrcode.components(separatedBy: ",")[1]) {
            qrImageView.image = UIImage(data: imageData)
        }
    }
}
