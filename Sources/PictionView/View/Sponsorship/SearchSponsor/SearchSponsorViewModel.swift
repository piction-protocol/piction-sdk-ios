//
//  SearchSponsorViewModel.swift
//  PictionSDK
//
//  Created by jhseo on 19/08/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import PictionSDK

final class SearchSponsorViewModel: ViewModel {

    init() {}

    struct Input {
        let viewWillAppear: Driver<Void>
        let viewWillDisappear: Driver<Void>
        let searchText: Driver<String>
        let selectedIndexPath: Driver<IndexPath>
    }

    struct Output {
        let viewWillAppear: Driver<Void>
        let viewWillDisappear: Driver<Void>
        let userList: Driver<[UserModel]>
        let openSendDonationViewController: Driver<IndexPath>
    }

    func build(input: Input) -> Output {
        let viewWillAppear = input.viewWillAppear

        let viewWillDisappear = input.viewWillDisappear

        let openSendDonationViewController = input.selectedIndexPath

        let searchAction = input.searchText
            .filter { $0 != "" }
            .flatMap { searchText -> Driver<Action<ResponseData>> in
                let response = PictionSDK.rx.requestAPI(SearchAPI.writer(writer: searchText))
                return Action.makeDriver(response)
            }

        let searchTextIsEmpty = input.searchText
            .filter { $0 == "" }
            .flatMap { _ -> Driver<[UserModel]> in
                return Driver.just([])
            }

        let searchActionSuccess = searchAction.elements
            .flatMap { response -> Driver<[UserModel]> in
                guard let user = try? response.map(to: [UserModel].self) else {
                    return Driver.empty()
                }
                return Driver.just(user)
            }

        let userList = Driver.merge(searchActionSuccess, searchTextIsEmpty)

        return Output(
            viewWillAppear: viewWillAppear,
            viewWillDisappear: viewWillDisappear,
            userList: userList,
            openSendDonationViewController: openSendDonationViewController
        )
    }
}
