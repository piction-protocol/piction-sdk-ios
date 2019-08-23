//
//  SendDonationViewModel.swift
//  PictionSDK
//
//  Created by jhseo on 19/08/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import PictionSDK

final class SendDonationViewModel: InjectableViewModel {
    typealias Dependency = (
        UpdaterProtocol,
        String
    )

    private let updater: UpdaterProtocol
    var loginId: String = ""

    init(dependency: Dependency) {
        (updater, loginId) = dependency
    }

    struct Input {
        let viewWillAppear: Driver<Void>
        let amountTextFieldDidInput: Driver<String>
        let sendBtnDidTap: Driver<Void>
    }

    struct Output {
        let viewWillAppear: Driver<Void>
        let userInfo: Driver<UserModel>
        let walletInfo: Driver<WalletModel>
        let enableSendButton: Driver<Bool>
        let openConfirmDonationViewController: Driver<(String, Int)>
    }

    func build(input: Input) -> Output {
        let viewWillAppear = input.viewWillAppear

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

        let walletInfoAction = viewWillAppear
            .flatMap { _ -> Driver<Action<ResponseData>> in
                let response = PictionSDK.rx.requestAPI(MyAPI.wallet)

                return Action.makeDriver(response)
            }

        let walletInfoSuccess = walletInfoAction.elements
            .flatMap { response -> Driver<WalletModel> in
                guard let walletInfo = try? response.map(to: WalletModel.self) else {
                    return Driver.empty()
                }
                return Driver.just(walletInfo)
            }

        let latestSendInfo = Driver.combineLatest(userInfoSuccess, walletInfoSuccess, input.amountTextFieldDidInput)

        let sendAmountAction = input.sendBtnDidTap
            .withLatestFrom(latestSendInfo)
            .flatMap { (userInfo, walletInfo, sendAmount) -> Driver<Action<ResponseData>> in
                let response = PictionSDK.rx.requestAPI(SponsorshipsAPI.sponsorship(creatorId: userInfo.loginId ?? "", amount: Int(sendAmount) ?? 0))
                return Action.makeDriver(response)
            }

        let sendAmountSuccess = sendAmountAction.elements
            .withLatestFrom(latestSendInfo)
            .flatMap { (userInfo, walletInfo, sendAmount) -> Driver<(String, Int)> in
                return Driver.just((userInfo.loginId ?? "", Int(sendAmount) ?? 0))
            }

        let enableSendButton = input.amountTextFieldDidInput
            .flatMap { text -> Driver<Bool> in
                return Driver.just(!text.isEmpty && (Int(text) ?? 0 > 0))
            }


        return Output(
            viewWillAppear: viewWillAppear,
            userInfo: userInfoSuccess,
            walletInfo: walletInfoSuccess,
            enableSendButton: enableSendButton,
            openConfirmDonationViewController: sendAmountSuccess
        )
    }
}
