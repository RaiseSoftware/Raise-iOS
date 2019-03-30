//
//  CreateViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 2/3/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit
import SVProgressHUD

class CreateViewController: HomeItemViewController {

    @IBOutlet private var deckTypeSegmentedControl: UISegmentedControl!
    @IBOutlet private var userNameTextField: UITextField!
    @IBOutlet private var gameNameTextField: UITextField!
    @IBOutlet private var createGameButton: UIButton!

    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func textFieldEditingChanged() {
        createGameButton.isEnabled = userNameTextField.hasText && gameNameTextField.hasText
    }

    @IBAction func setPasswordPressed() {
        dismissKeyboard()
        promptForPassword()
    }

    private func promptForPassword() {
        let alertController = UIAlertController(title: "Enter Passcode", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.keyboardType = .numberPad
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let submitAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            if let passcode = alertController.textFields?.first?.text {
                self?.createGame(passcode: passcode)
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)

        present(alertController, animated: true)
    }


    private func createGame(passcode: String) {
        guard let gameName = gameNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let moderatorName = userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                assertionFailure("Missing game or user name")
                return
        }

        guard !gameName.isEmpty, !moderatorName.isEmpty else {
            presentErrorAlert(message: "Please complete all fields")
            return
        }

        let deckType: DeckType
        if deckTypeSegmentedControl.selectedSegmentIndex == 0 {
            deckType = .fibonacci
        } else {
            deckType = .tshirt
        }

        let player = Player(name: moderatorName, roles: [.moderator])
        let pokerGame = PokerGame(gameName: gameName, deckType: deckType, qrcode: "", passcode: passcode, players: [player])
        SVProgressHUD.show()
        API.createGame(pokerGame) { [weak self] error in
            SVProgressHUD.dismiss()
            if let error = error {
                self?.presentErrorAlert(message: error.localizedDescription)
            } else {
                if let gameDetailsViewController = UIStoryboard(name: "GameDetails", bundle: nil).instantiateInitialViewController() as? GameDetailsViewController {
                    gameDetailsViewController.game = pokerGame
                    self?.present(gameDetailsViewController, animated: true)
                }
            }
        }
    }
}

extension CreateViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            return gameNameTextField.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }
}
