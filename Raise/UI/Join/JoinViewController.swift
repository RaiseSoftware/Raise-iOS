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
