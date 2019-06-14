//
//  ProjectsUpdateViewController.swift
//  Piction-SDK-iOS-Example
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import PictionSDK

class ProjectsUpdateViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var synopsisTextField: UITextField!
    @IBOutlet weak var thumbnailTextField: UITextField!
    @IBOutlet weak var wideThumbnailTextField: UITextField!
    
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

        PictionSDK.projects.update(id: idTextField.text ?? "", title: titleTextField.text ?? "", synopsis: synopsisTextField.text ?? "", thumbnail: thumbnailTextField.text ?? "", wideThumbnail: wideThumbnailTextField.text ?? "",
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

        let alert = UIAlertController(title: nil, message: "Input ProjectId", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in

            let inputId = alert.textFields?.first?.text ?? ""

            self.responseTextView.text = ""
            self.isLoading = true
            PictionSDK.projects.all(
                success: { response in
                    let currentProject = response.filter { $0.id == inputId }.first
                    self.idTextField.text = inputId
                    self.titleTextField.text = currentProject?.title
                    self.synopsisTextField.text = currentProject?.synopsis
                    self.responseTextView.text = String(describing: currentProject)
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

        alert.addTextField(configurationHandler: configurationTextField)


        present(alert, animated: false, completion: nil)

        self.isLoading = true

    }

    private func configurationTextField(textField: UITextField!){
        textField.placeholder = "Project ID"
    }
}
