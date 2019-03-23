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
        guard let gameName = gameNameTextField.text, let moderatorName = userNameTextField.text else {
            assertionFailure("Missing game or user name")
            return
        }

        let deckType: DeckType
        if deckTypeSegmentedControl.selectedSegmentIndex == 0 {
            deckType = .fibonacci
        } else {
            deckType = .tshirt
        }

        let request = CreateRequest(gameName: gameName, deckType: deckType, passcode: passcode, moderatorName: moderatorName)
        SVProgressHUD.show()
        API.createGame(request) { [weak self] response in
            SVProgressHUD.dismiss()
            if let response = response, let gameDetailsViewController = UIStoryboard(name: "GameDetails", bundle: nil).instantiateInitialViewController() as? GameDetailsViewController {
                gameDetailsViewController.gameResponse = response
                self?.navigationController?.pushViewController(gameDetailsViewController, animated: true)
            } else {
                self?.presentErrorAlert(message: "Unable to create game. Please try again.")
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
