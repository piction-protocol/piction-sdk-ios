//
//  PostsUploadContentImageViewController.swift
//  Piction-SDK-iOS-Example
//
//  Created by jhseo on 13/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import PictionSDK

class PostsUploadContentImageViewController: UIViewController {
    @IBOutlet weak var projectIdTextField: UITextField!
    @IBOutlet weak var selectImageButton: UIButton!

    @IBOutlet weak var responseTextView: UITextView!
    @IBOutlet weak var executeButton: UIButton!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var selectedImage: UIImage?

    var isLoading: Bool = false {
        didSet(loading) {
            loading ? self.activityIndicator.stopAnimating() : self.activityIndicator.startAnimating()
            self.executeButton.isEnabled = loading
            self.selectImageButton.isEnabled = loading
        }
    }

    @IBAction func selectedImageBtnPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary

        self.present(picker, animated: true, completion: nil)
    }

    @IBAction func executeBtnPressed(_ sender: Any) {
        self.responseTextView.text = ""
        self.isLoading = true

        PictionSDK.posts.uploadContentImage(projectId: projectIdTextField.text ?? "", image: self.selectImageButton.backgroundImage(for: .normal) ?? UIImage(),
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

extension PostsUploadContentImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dismiss(animated: true) { [weak self] in
                self?.selectedImage = chosenImage
                self?.selectImageButton.setBackgroundImage(chosenImage, for: .normal)
                self?.selectImageButton.setTitle("", for: .normal)
            }
        }
    }
}
