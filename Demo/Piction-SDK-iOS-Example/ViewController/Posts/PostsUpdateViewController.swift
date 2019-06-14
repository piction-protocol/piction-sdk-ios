//
//  PostsUpdateViewController.swift
//  Piction-SDK-iOS-Example
//
//  Created by jhseo on 13/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import PictionSDK

class PostsUpdateViewController: UIViewController {
    @IBOutlet weak var projectIdTextField: UITextField!
    @IBOutlet weak var postIdTextField: UITextField!
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

        PictionSDK.posts.update(projectId: projectIdTextField.text ?? "", postId: postIdTextField.text ?? "", title: titleTextField.text ?? "", content: contentTextField.text ?? "", cover: coverTextField.text ?? "", status: statusTextField.text ?? "", membership: membershipTextField.text ?? "", seriesId: seriesIdTextField.text ?? "",
            success: { response in
                self.responseTextView.text = String(describing: response)
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

        let alert = UIAlertController(title: nil, message: "Input ProjectID and PostID", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in

            let inputProjectId = alert.textFields?.first?.text ?? ""
            let inputPostId = alert.textFields?.last?.text ?? ""

            self.responseTextView.text = ""
            self.isLoading = true
            PictionSDK.posts.get(projectId: inputProjectId, postId: inputPostId,
                success: { response in
                    self.projectIdTextField.text = inputProjectId
                    self.postIdTextField.text = inputPostId
                    self.titleTextField.text = response.title
                    self.contentTextField.text = response.content
                    self.statusTextField.text = response.status
                    self.seriesIdTextField.text = String(response.series?.id ?? 0)
                    self.responseTextView.text = String(describing: response)
                    self.isLoading = false
            },
                failure: { error in
                    self.responseTextView.text = String(describing: error)
                    self.isLoading = false
            })

        })
        alert.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler : nil)
        alert.addAction(cancelAction)

        alert.addTextField(configurationHandler: configurationProjectIdTextField)
        alert.addTextField(configurationHandler: configurationPostIdTextField)

        present(alert, animated: false, completion: nil)

        self.isLoading = true

    }

    private func configurationProjectIdTextField(textField: UITextField!){
        textField.placeholder = "Project ID"
    }

    private func configurationPostIdTextField(textField: UITextField!){
        textField.placeholder = "Post ID"
    }
}
