//
//  ConfirmDonationViewModel.swift
//  PictionSDK
//
//  Created by jhseo on 20/08/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import PictionSDK

final class ConfirmDonationViewModel: InjectableViewModel {
    typealias Dependency = (
        UpdaterProtocol,
        String,
        Int
    )

    private let updater: UpdaterProtocol
    var loginId: String = ""
    var sendAmount: Int = 0

    init(dependency: Dependency) {
        (updater, loginId, sendAmount) = dependency
    }

    struct Input {
        let viewWillAppear: Driver<Void>
        let confirmBtnDidTap: Driver<Void>
    }

    struct Output {
        let viewWillAppear: Driver<Void>
        let sendAmountInfo: Driver<Int>
        let userInfo: Driver<UserModel>
        let popViewController: Driver<Void>
    }

    func build(input: Input) -> Output {
        let viewWillAppear = input.viewWillAppear

        let sendAmountInfo = input.viewWillAppear
            .flatMap { [weak self] _ -> Driver<Int> in
                guard let `self` = self else { return Driver.empty() }
                return Driver.just(self.sendAmount)
            }

        let userInfoAction = viewWillAppear
            .flatMap { [weak self] _ -> Driver<Action<ResponseData>> in
                let response = PictionSDK.rx.requestAPI(UsersAPI.findOne(id: self?.loginId ?? ""))

                return Action.makeDriver(response)
            }

        let userInfoSuccess = userInfoAction.elements
            .flatMap { response -> Driver<UserModel> in
                guard let user = try? response.map(to: UserModel.self) else {
                    return Driver.empty()
                }
                return Driver.just(user)
            }

        let popViewController = input.confirmBtnDidTap

//        let sendAmountAction = input.sendBtnDidTap
//            .flatMap { _ -> Driver<Action<ResponseData>> in
//                let response = PictionSDK.rx.requestAPI(SponsorshipsAPI.sponsorship(creatorId: self.loginId, amount: self.sendAmount))
//                return Action.makeDriver(response)
//            }
//
//        let sendAmountSuccess = sendAmountAction.elements
//            .flatMap { response -> Driver<Void> in
//                return Driver.just(())
//            }

        return Output(
            viewWillAppear: viewWillAppear,
            sendAmountInfo: sendAmountInfo,
            userInfo: userInfoSuccess,
            popViewController: popViewController
        )
    }
}