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
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pictureTextField: UITextField!
    
    @IBOutlet weak var responseTextView: UITextView!
    @IBOutlet weak var executeButton: UIButton!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var isLoading: Bool = false {
        didSet(loading) {
            loading ? self.activityIndicator.stopAnimating() : self.activityIndicator.startAnimating()
            self.executeButton.isEnabled = loading
        }
    }
    
    @IBAction func executeBtnPressed(_ sender: Any) {
        self.responseTextView.text = ""
        self.isLoading = true
        
        PictionSDK.users.update(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "", picture: pictureTextField.text ?? "",
            success: { response in
                self.responseTextView.text = JsonUtil.toString(dict: response.toDict())
                self.isLoading = false
            },
            failure: { error in
                self.responseTextView.text = String(describing: error)
                self.isLoading = false
            })
    }

    @IBAction func loadBtnPressed(_ sender: Any) {
        guard PictionManager.isLogin else {
            let alert = UIAlertController(title: nil, message: "Require log in", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(defaultAction)

            present(alert, animated: false, completion: nil)
            return
        }

        self.responseTextView.text = ""
        self.isLoading = true
        PictionSDK.users.me(
            success: { response in
                self.usernameTextField.text = response.username
                self.responseTextView.text = JsonUtil.toString(dict: response.toDict())
                self.isLoading = false
            },
            failure: { error in
                self.responseTextView.text = String(describing: error)
                self.isLoading = false
            })
    }
}
