//
//  UsersUpdateViewController.swift
//  Piction-SDK-iOS-Example
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import PictionSDK

class UsersUpdateViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pictureTextField: UITextField!
    @IBOutlet weak var responseTextView: UITextView!

    @IBAction func executeBtnPressed(_ sender: Any) {
        self.responseTextView.text = ""
        
        PictionSDK.users.update(email: emailTextField.text ?? "", username: usernameTextField.text ?? "", password: passwordTextField.text ?? "", picture: pictureTextField.text ?? "",
            success: { response in
                self.responseTextView.text = String(describing: response)
        },
            failure: { error in
                self.responseTextView.text = String(describing: error)
        })
    }
}
