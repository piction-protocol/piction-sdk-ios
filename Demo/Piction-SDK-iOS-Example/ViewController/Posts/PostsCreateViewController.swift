//
//  PostsCreateViewController.swift
//  Piction-SDK-iOS-Example
//
//  Created by jhseo on 13/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import PictionSDK

class PostsCreateViewController: UIViewController {
    @IBOutlet weak var projectIdTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var coverTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var membershipTextField: UITextField!
    @IBOutlet weak var seriesIdTextField: UITextField!

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

        PictionSDK.posts.create(projectId: projectIdTextField.text ?? "", title: titleTextField.text ?? "", content: contentTextField.text ?? "", cover: coverTextField.text ?? "", status: statusTextField.text ?? "", membership: membershipTextField.text ?? "", seriesId: seriesIdTextField.text ?? "",
            success: { response in
                self.responseTextView.text = String(describing: response)
                self.isLoading = false
            },
            failure: { error in
                self.responseTextView.text = String(describing: error)
                self.isLoading = false
            })
    }
}
