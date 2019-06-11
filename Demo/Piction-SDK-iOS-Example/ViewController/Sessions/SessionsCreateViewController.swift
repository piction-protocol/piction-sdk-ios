//
//  SessionsCreateViewController.swift
//  Piction-SDK-iOS-Example
//
//  Created by jhseo on 20/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import PictionSDK

class SessionsCreateViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var responseTextView: UITextView!

    @IBAction func executeBtnPressed(_ sender: Any) {
        self.responseTextView.text = ""
        
        PictionSDK.sessions.create(email: emailTextField.text ?? "", password: passwordTextField.text ?? "",
            success: { response in
                self.responseTextView.text = String(describing: response)
            },
            failure: { error in
                self.responseTextView.text = String(describing: error)
            })
    }
}

