//
//  SeriesUpdatePriorityViewController.swift
//  Piction-SDK-iOS-Example
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import PictionSDK

class SeriesUpdatePriorityViewController: UIViewController {
    @IBOutlet weak var projectIdTextField: UITextField!
    @IBOutlet weak var seriesIdListTextField: UITextField!

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

        let idListArray = seriesIdListTextField.text?.components(separatedBy: ",")
        let seriesIdList = idListArray?.compactMap { Int($0)! } ?? []

        PictionSDK.series.updatePriority(projectId: projectIdTextField.text ?? "", seriesIdList: seriesIdList,
            success: { response in
                self.responseTextView.text = JsonUtil.toString(dict: response.map { $0.toDict() })
                self.isLoading = false
        },
            failure: { error in
                self.responseTextView.text = String(describing: error)
                self.isLoading = false
        })
    }
}
