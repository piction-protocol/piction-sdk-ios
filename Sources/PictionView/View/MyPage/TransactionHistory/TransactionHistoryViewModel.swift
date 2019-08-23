//
//  TransactionHistoryViewModel.swift
//  PictionView
//
//  Created by jhseo on 19/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import PictionSDK
import RxPictionSDK

final class TransactionHistoryViewModel: ViewModel {

    var page = 0
    var sections: [TransactionHistoryItemType] = []
    var shouldInfiniteScroll = true

    var loadTrigger = PublishSubject<Void>()

    init() {}

    struct Input {
        let viewWillAppear: Driver<Void>
        let refreshControlDidRefresh: Driver<Void>
    }

    struct Output {
        let viewWillAppear: Driver<Void>
        let transactionList: Driver<TransactionHistoryBySection>
        let isFetching: Driver<Bool>
        let activityIndicator: Driver<Bool>
    }

    func build(input: Input) -> Output {
        let viewWillAppear = input.viewWillAppear.asObservable().take(1).asDriver(onErrorDriveWith: .empty())

        let initialLoad = Driver.merge(viewWillAppear, input.refreshControlDidRefresh)
            .flatMap { [weak self] _ -> Driver<Void> in
                guard let `self` = self else { return Driver.empty() }
                self.page = 1
                self.sections = []
                self.shouldInfiniteScroll = true
                return Driver.just(())
            }

        let loadNext = loadTrigger.asDriver(onErrorDriveWith: .empty())
            .flatMap { [weak self] _ -> Driver<Void> in
                guard let `self` = self, self.shouldInfiniteScroll else {
                    return Driver.empty()
                }
                self.page = self.page + 1
                return Driver.just(())
            }

        let transactionHistoryAction = Driver.merge(initialLoad, loadNext)
            .flatMap { [weak self] _ -> Driver<Action<ResponseData>> in
                guard let `self` = self else { return Driver.empty() }
                let response = PictionSDK.rx.requestAPI(MyAPI.transactions(page: self.page, size: 10))
                return Action.makeDriver(response)
            }

       let transactionHistorySuccess = transactionHistoryAction.elements
            .flatMap { [weak self] response -> Driver<TransactionHistoryBySection> in
                guard let `self` = self else { return Driver.empty() }
                guard let pageList = try? response.map(to: PageViewResponse<TransactionModel>.self) else {
                    return Driver.empty()
                }
                if (pageList.pageable?.pageNumber ?? 0) >= (pageList.totalPages ?? 0) - 1 {
                    self.shouldInfiniteScroll = false
                }
                let transactions: [TransactionHistoryItemType] = (pageList.content ?? []).map { .list(model: $0) }
//                let contents: [TransactionModel] = pageList.content ?? []
//                let dayKey = Set<String>(contents.map { $0.createdAt?.toString(format: "YYYY-MM-dd") ?? ""})
//
//                var resultArray: [TransactionModel] = []
//                for key in dayKey {
//                    let sum = contents.filter({ ($0.createdAt?.toString(format: "YYYY-MM-dd") ?? "") == key })
//                    resultArray.append(contentsOf: sum)
//                }
                self.sections.append(contentsOf: [.header])
                self.sections.append(contentsOf: transactions)
                return Driver.just(TransactionHistoryBySection.Section(title: "transacation", items: self.sections))
            }

        let transactionHistoryError = transactionHistoryAction.error
            .flatMap { response -> Driver<TransactionHistoryBySection> in
                return Driver.just(TransactionHistoryBySection.Section(title: "transacation", items: self.sections))
            }

        let refreshAction = input.refreshControlDidRefresh
            .withLatestFrom(transactionHistorySuccess)
            .flatMap { list -> Driver<Action<TransactionHistoryBySection>> in
                return Action.makeDriver(Driver.just(list))
            }

        let showActivityIndicator = Driver.merge(initialLoad)
            .flatMap { _ in Driver.just(true) }

        let hideActivityIndicator = Driver.merge(transactionHistorySuccess, transactionHistoryError)
            .flatMap { _ in Driver.just(false) }

        let activityIndicator = Driver.merge(showActivityIndicator, hideActivityIndicator)
            .flatMap { status in Driver.just(status) }


        return Output(
            viewWillAppear: input.viewWillAppear,
            transactionList: transactionHistorySuccess,
            isFetching: refreshAction.isExecuting,
            activityIndicator: activityIndicator
        )
    }

    fileprivate func firstDayOfMonth(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components)!
    }
}
