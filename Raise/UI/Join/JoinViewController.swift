//
//  JoinViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 2/19/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit
import SVProgressHUD

class JoinViewController: HomeItemViewController {

    @IBOutlet private var userNameTextField: UITextField!
    @IBOutlet private var gameIDTextField: UITextField!
    @IBOutlet private var joinGameButton: UIButton!

    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func textFieldEditingChanged() {
        joinGameButton.isEnabled = userNameTextField.hasText && gameIDTextField.hasText
    }

    @IBAction func joinPressed() {
        dismissKeyboard()

        makeAPIRequest()
    }

    func makeAPIRequest(passcode: String? = nil) {
        guard let gameId = gameIDTextField.text, let name = userNameTextField.text else {
            assertionFailure("Missing game id or user name")
            return
        }
        
        SVProgressHUD.show()
        API.findGame(gameId, name: name, passcode: passcode, success: { [weak self] response in
            SVProgressHUD.dismiss()
            if let gameDetailsViewController = UIStoryboard(name: "GameDetails", bundle: nil).instantiateInitialViewController() as? GameDetailsViewController {
                gameDetailsViewController.gameResponse = response
                self?.navigationController?.pushViewController(gameDetailsViewController, animated: true)
            } else {
                self?.presentErrorAlert(message: "Unable to join game. Please verify code and try again.")
            }
        }, failure: { [weak self] error, needsPassword in
            SVProgressHUD.dismiss()
            if needsPassword {
                self?.promptForPassword()
            } else {
                self?.presentErrorAlert(message: "Unable to join game. Please verify code and try again.")
            }
        })
    }

    func promptForPassword() {
        let alertController = UIAlertController(title: "Enter Passcode", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .allCharacters
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
            if let passcode = alertController.textFields?.first?.text {
                self?.makeAPIRequest(passcode: passcode)
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)

        present(alertController, animated: true)
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
