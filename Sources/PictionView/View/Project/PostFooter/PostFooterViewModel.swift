//
//  PostFooterViewModel.swift
//  PictionView
//
//  Created by jhseo on 11/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import PictionSDK
import RxPictionSDK

final class PostFooterViewModel: InjectableViewModel {
    typealias Dependency = (
        UpdaterProtocol,
        String,
        Int
    )

    private let updater: UpdaterProtocol
    private var uri: String = ""
    private var postId: Int = 0

    init(dependency: Dependency) {
        (updater, uri, postId) = dependency
    }

    struct Input {
        let viewWillAppear: Driver<Void>
        let likeBtnDidTap: Driver<Void>
    }

    struct Output {
        let footerInfo: Driver<(PostModel, Bool)>
        let addLike: Driver<Bool>
        let openSignInViewController: Driver<Void>
    }

    func build(input: Input) -> Output {

        let viewWillAppear = input.viewWillAppear.asObservable().take(1).asDriver(onErrorDriveWith: .empty())

        let refreshContent = updater.refreshContent.asDriver(onErrorDriveWith: .empty())
        let refreshSession = updater.refreshSession.asDriver(onErrorDriveWith: .empty())

        let isLikeAction = Driver.merge(viewWillAppear, refreshContent, refreshSession)
            .flatMap { [weak self] _ -> Driver<Action<ResponseData>> in
                let response = PictionSDK.rx.requestAPI(PostsAPI.isLike(uri: self?.uri ?? "", postId: self?.postId ?? 0))
                return Action.makeDriver(response)
            }

        let isLikeSuccess = isLikeAction.elements
            .flatMap { response -> Driver<Bool> in
                guard let likeInfo = try? response.map(to: LikeModel.self) else {
                    return Driver.empty()
                }
                return Driver.just(likeInfo.like ?? false)
            }

        let isLikeError = isLikeAction.error
            .flatMap { _ in Driver.just(false) }

        let isLikeInfo = Driver.merge(isLikeSuccess, isLikeError)

        let postItemAction = Driver.merge(viewWillAppear, refreshContent, refreshSession)
            .flatMap { [weak self] _ -> Driver<Action<ResponseData>> in
                let response = PictionSDK.rx.requestAPI(PostsAPI.get(uri: self?.uri ?? "", postId: self?.postId ?? 0))
                return Action.makeDriver(response)
            }

        let postItemSuccess = postItemAction.elements
            .flatMap { response -> Driver<PostModel> in
                guard let postItem = try? response.map(to: PostModel.self) else {
                    return Driver.empty()
                }
                return Driver.just(postItem)
            }

        let footerInfo = Driver.combineLatest(postItemSuccess, isLikeInfo)
            .flatMap { (postItem, isLike) -> Driver<(PostModel, Bool)> in
                return Driver.just((postItem, isLike))
        }

        let userInfoAction = Driver.merge(refreshContent, input.viewWillAppear, refreshSession)
            .flatMap { _ -> Driver<Action<ResponseData>> in
                let response = PictionSDK.rx.requestAPI(UsersAPI.me)
                return Action.makeDriver(response)
        }

        let userInfoSuccess = userInfoAction.elements
            .flatMap { response -> Driver<UserModel> in
                guard let userInfo = try? response.map(to: UserModel.self) else {
                    return Driver.empty()
                }
                return Driver.just(userInfo)
        }

        let userInfoError = userInfoAction.error
            .flatMap { response -> Driver<UserModel> in
                return Driver.just(UserModel.from([:])!)
        }

        let userInfo = Driver.merge(userInfoSuccess, userInfoError)

        let addLike = input.likeBtnDidTap
            .withLatestFrom(userInfo)
            .filter { $0.loginId != nil }
            .flatMap { [weak self] _ -> Driver<Action<ResponseData>> in
                let response = PictionSDK.rx.requestAPI(PostsAPI.like(uri: self?.uri ?? "", postId: self?.postId ?? 0))
                return Action.makeDriver(response)
            }

        let openSignInViewController = input.likeBtnDidTap
            .withLatestFrom(userInfo)
            .filter { $0.loginId == nil }
            .flatMap { _ in Driver.just(()) }

        return Output(
            footerInfo: footerInfo,
            addLike: addLike.isExecuting,
            openSignInViewController: openSignInViewController
        )
    }
}
