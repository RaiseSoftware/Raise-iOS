//
//  JoinViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 2/19/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var gameIDTextField: UITextField!
    @IBOutlet weak var joinGameButton: UIButton!

    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func textFieldEditingChanged() {
        joinGameButton.isEnabled = userNameTextField.hasText && gameIDTextField.hasText
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let navController = segue.destination as? UINavigationController, let qrCodeViewController = navController.viewControllers.first as? QRCodeScannerViewController {
            qrCodeViewController.delegate = self
        }
    }
}

extension JoinViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            return gameIDTextField.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }
}

extension JoinViewController: QRCodeScannerViewControllerDelegate {

    func qrCodeFound(value: String) {
        if let gameInfo = value.toDictionary() {
            gameIDTextField.text = gameInfo["gameId"] as? String
        }
    }
}
