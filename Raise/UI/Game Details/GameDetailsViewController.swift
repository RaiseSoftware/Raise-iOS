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
    @IBOutlet weak var qrCodeButton: UIButton!

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

        let base64QRCodeImageComponents = gameResponse.pokerGame.qrcode.components(separatedBy: ",")
        if base64QRCodeImageComponents.count > 1, let imageData = Data(base64Encoded: base64QRCodeImageComponents[1]) {
            qrCodeButton.imageView?.contentMode = .scaleAspectFit
            qrCodeButton.setImage(UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }

    @IBAction func qrCodeTapped() {
        guard let qrCodeImage = qrCodeButton.image(for: .normal) else {
            assertionFailure("Unable to get QR code")
            return
        }

        let activityViewController = UIActivityViewController(activityItems: [qrCodeImage], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}
