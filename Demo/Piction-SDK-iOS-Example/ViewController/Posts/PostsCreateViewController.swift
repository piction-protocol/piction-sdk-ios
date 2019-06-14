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
    @IBOutlet weak var projectIdTextView: UITextField!
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var contentTextView: UITextField!
    @IBOutlet weak var coverTextView: UITextField!
    @IBOutlet weak var statusTextView: UITextField!
    @IBOutlet weak var membershipTextView: UITextField!
    @IBOutlet weak var seriesIdTextView: UITextField!

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

        PictionSDK.posts.create(projectId: projectIdTextView.text ?? "", title: titleTextView.text ?? "", content: contentTextView.text ?? "", cover: coverTextView.text ?? "", status: statusTextView.text ?? "", membership: membershipTextView.text ?? "", seriesId: seriesIdTextView.text ?? "",
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
