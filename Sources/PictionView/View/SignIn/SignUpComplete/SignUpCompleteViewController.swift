//
//  SignUpCompleteViewController.swift
//  PictionView
//
//  Created by jhseo on 19/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable

final class SignUpCompleteViewController: UIViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}

extension SignUpCompleteViewController: ViewModelBindable {

    typealias ViewModel = SignUpCompleteViewModel

    func bindViewModel(viewModel: ViewModel) {

        let input = SignUpCompleteViewModel.Input(
            closeBtnDidTap: closeButton.rx.tap.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .dismissViewController
            .drive(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
