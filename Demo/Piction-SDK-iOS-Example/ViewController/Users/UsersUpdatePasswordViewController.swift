//
//  UsersUpdatePasswordViewController.swift
//  Piction-SDK-iOS-Example
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import PictionSDK

class UsersUpdatePasswordViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var responseTextView: UITextView!

    @IBAction func executeBtnPressed(_ sender: Any) {
        self.responseTextView.text = ""
        
        PictionSDK.users.updatePassword(password: passwordTextField.text ?? "", newPassword: newPasswordTextField.text ?? "", confirmPassword: confirmPasswordTextField.text ?? "",
            success: { response in
                self.responseTextView.text = String(describing: response)
            },
            failure: { error in
                self.responseTextView.text = String(describing: error)
            })
    }
}
