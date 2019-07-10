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
    @IBOutlet weak var uriTextField: UITextField!
    @IBOutlet weak var postIdTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var coverTextField: UITextField!
    @IBOutlet weak var requiredSubscriptionTextField: UITextField!
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

        PictionSDK.posts.update(uri: uriTextField.text ?? "", postId: Int(postIdTextField.text ?? "0") ?? 0, title: titleTextField.text ?? "", content: contentTextField.text ?? "", cover: coverTextField.text ?? "", requiredSubscription: Bool(requiredSubscriptionTextField.text ?? "false") ?? false, seriesId: seriesIdTextField.text ?? "",
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

            let inputUri = alert.textFields?.first?.text ?? ""
            let inputPostId = alert.textFields?.last?.text ?? "0"

            self.responseTextView.text = ""
            self.isLoading = true
            PictionSDK.posts.get(uri: inputUri, postId: Int(inputPostId) ?? 0,
                success: { response in
                    self.uriTextField.text = inputUri
                    self.postIdTextField.text = inputPostId
                    self.titleTextField.text = response.title
                    self.requiredSubscriptionTextField.text = String(response.requiredSubscription ?? false)
                    self.seriesIdTextField.text = String(response.series?.id ?? 0)
                    self.responseTextView.text = JsonUtil.toString(dict: response.toDict())
                    self.isLoading = false
                },
                failure: { error in
                    self.responseTextView.text = String(describing: error)
                    self.isLoading = false
                })

            PictionSDK.posts.content(uri: inputUri, postId: Int(inputPostId) ?? 0,
                success: { response in
                    self.contentTextField.text = response.content
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
    }

    private func configurationProjectIdTextField(textField: UITextField!){
        textField.placeholder = "Project ID"
    }

    private func configurationPostIdTextField(textField: UITextField!){
        textField.placeholder = "Post ID"
    }
}
