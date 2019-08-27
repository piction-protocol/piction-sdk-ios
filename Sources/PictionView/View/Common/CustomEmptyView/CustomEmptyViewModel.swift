//
//  CustomEmptyViewModel.swift
//  PictionSDK
//
//  Created by jhseo on 05/08/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum CustomEmptyViewStyle {
    case defaultLogin
    case projectPostListEmpty
    case projectSeriesListEmpty
    case sponsorshipListEmpty
    case sponsorshipListLogin
    case subscriptionListEmpty
    case searchProjectListEmpty
    case transactionListEmpty
    case myProjectListEmpty

    var image: UIImage {
        switch self {
        case .defaultLogin,
             .projectPostListEmpty,
             .projectSeriesListEmpty,
             .subscriptionListEmpty,
             .searchProjectListEmpty,
             .transactionListEmpty,
             .myProjectListEmpty:
            return #imageLiteral(resourceName: "icMoodBad")
        case .sponsorshipListEmpty,
             .sponsorshipListLogin:
            return #imageLiteral(resourceName: "icStartup")
        }
    }

    var description: String {
        switch self {
        case .defaultLogin,
             .sponsorshipListLogin:
            return "로그인이 필요합니다."
        case .projectPostListEmpty:
            return "등록된 포스트가 없습니다."
        case .projectSeriesListEmpty:
            return "등록된 시리즈가 없습니다."
        case .sponsorshipListEmpty:
            return "아직 후원 기록이 없습니다.\n지금 바로 크리에이터를 후원해보세요!"
        case .subscriptionListEmpty:
            return "아직 구독 중인\n프로젝트가 없습니다."
        case .searchProjectListEmpty:
            return "검색 결과가 없습니다."
        case .transactionListEmpty:
            return "거래 내역이 없습니다."
        case .myProjectListEmpty:
            return "등록된 프로젝트가 없습니다."

        }
    }

    var buttonTitle: String? {
        switch self {
        case .defaultLogin,
             .sponsorshipListLogin:
            return "로그인"
        case .projectPostListEmpty,
             .projectSeriesListEmpty,
             .sponsorshipListEmpty,
             .subscriptionListEmpty,
             .searchProjectListEmpty,
             .transactionListEmpty,
             .myProjectListEmpty:
            return nil
        }
    }
}

final class CustomEmptyViewModel: ViewModel {

    private let style: CustomEmptyViewStyle

    init(style: CustomEmptyViewStyle) {
        self.style = style
    }

    struct Input {
        let viewWillAppear: Driver<Void>
        let btnDidTap: Driver<Void>
    }

    struct Output {
        let emptyViewStyle: Driver<CustomEmptyViewStyle>
        let buttonAction: Driver<CustomEmptyViewStyle>
    }

    func build(input: Input) -> Output {
        let emptyViewStyle = input.viewWillAppear
            .flatMap { return Driver.just(self.style) }

        let buttonAction = input.btnDidTap
            .flatMap { return Driver.just(self.style) }

        return Output(
            emptyViewStyle: emptyViewStyle,
            buttonAction: buttonAction
        )
    }
}

