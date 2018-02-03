//
//  CreateViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 2/3/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var createGameButton: UIButton!

    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func textFieldEditingChanged() {
        createGameButton.isEnabled = userNameTextField.hasText && gameNameTextField.hasText
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
