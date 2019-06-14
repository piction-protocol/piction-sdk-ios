//
//  UsersSignupViewController.swift
//  Piction-SDK-iOS-Example
//
//  Created by jhseo on 08/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import PictionSDK
//import RxSwift

class UsersSignupViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var responseTextView: UITextView!
    @IBOutlet weak var executeButton: UIButton!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

//    let disposeBag = DisposeBag()

    var isLoading: Bool = false {
        didSet(loading) {
            loading ? self.activityIndicator.stopAnimating() : self.activityIndicator.startAnimating()
            self.executeButton.isEnabled = loading
        }
    }

    @IBAction func executeBtnPressed(_ sender: Any) {
        self.responseTextView.text = ""
        self.isLoading = true

        PictionSDK.users.signup(email: emailTextField.text ?? "", username: usernameTextField.text ?? "", password: passwordTextField.text ?? "",
            success: { response in
                self.responseTextView.text = String(describing: response)
                self.isLoading = false
            },
            failure: { error in
                self.responseTextView.text = String(describing: error)
                self.isLoading = false
            })

// [Use RxSwift]
//        PictionSDK.rx.requestAPI(UsersAPI.me)
//            .map{ $0 as CurrentUserResponse }
//            .subscribe({ response in
//                print("moya1 = \(response)")
//            })
//            .disposed(by: disposeBag)

//        PictionSDK.users.rx.me()
//            .asObservable()
//            .subscribe(onNext: { response in
//                print("rx = \(response)")
//            })
//            .disposed(by: disposeBag)

// [Use Piction.requestAPI]
//        PictionSDK.requestAPI(UsersAPI.signup(email: emailTextField.text ?? "", username: usernameTextField.text ?? "", password: passwordTextField.text ?? ""),
//            success: { (response: AuthenticationResponse) in
//                self.responseTextView.text = String(describing: response)
//            },
//            failure: { error in
//                self.responseTextView.text = String(describing: error)
//            })
    }
}
