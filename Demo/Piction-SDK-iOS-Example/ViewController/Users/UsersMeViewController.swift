//
//  UsersMeViewController.swift
//  Piction-SDK-iOS-Example
//
//  Created by jhseo on 20/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import PictionSDK

class UsersMeViewController: UIViewController {
    @IBOutlet weak var currentTokenTextField: UITextField! {
        didSet {
            currentTokenTextField.text = PictionManager.getToken
        }
    }
    @IBOutlet weak var responseTextView: UITextView!

    @IBAction func executeBtnPressed(_ sender: Any) {
        self.responseTextView.text = ""
        
        PictionSDK.users.me(
            success: { response in
                self.responseTextView.text = String(describing: response)
            },
            failure: { error in
                self.responseTextView.text = String(describing: error)
            })
    }
}
