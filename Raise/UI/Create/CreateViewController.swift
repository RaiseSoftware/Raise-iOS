//
//  CreateViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 2/3/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit
import SVProgressHUD

class CreateViewController: UIViewController {

    @IBOutlet weak var deckTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var requiresPasswordSwitch: UISwitch!
    @IBOutlet weak var createGameButton: UIButton!

    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func textFieldEditingChanged() {
        createGameButton.isEnabled = userNameTextField.hasText && gameNameTextField.hasText
    }

    @IBAction func createGameButtonPressed() {
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

        let request = CreateRequest(gameName: gameName, deckType: deckType, requiresPassword: requiresPasswordSwitch.isOn, moderatorName: moderatorName)
        SVProgressHUD.show()
        API.createGame(request) { [weak self] response in
            SVProgressHUD.dismiss()
            if response != nil {
                self?.performSegue(withIdentifier: "showGameDetails", sender: nil)
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
