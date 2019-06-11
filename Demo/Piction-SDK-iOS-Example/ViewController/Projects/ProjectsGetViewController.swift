//
//  ProjectsGetViewController.swift
//  Piction-SDK-iOS-Example
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import PictionSDK

class ProjectsGetViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var responseTextView: UITextView!

    @IBAction func executeBtnPressed(_ sender: Any) {
        self.responseTextView.text = ""
        
        PictionSDK.projects.get(id: idTextField.text ?? "",
            success: { response in
                self.responseTextView.text = String(describing: response)
            },
            failure: { error in
                self.responseTextView.text = String(describing: error)
            })
    }
}
