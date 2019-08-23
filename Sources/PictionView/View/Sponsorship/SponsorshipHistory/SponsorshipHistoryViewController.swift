//
//  SponsorshipHistoryViewController.swift
//  PictionSDK
//
//  Created by jhseo on 20/08/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable
import RxDataSources
import PictionSDK

final class SponsorshipHistoryViewController: UITableViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var emptyView: UIView!

    private func configureDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, SponsorshipModel>> {
        return RxTableViewSectionedReloadDataSource<SectionModel<String, SponsorshipModel>>(
            configureCell: { dataSource, tableView, indexPath, model in
                let cell: SponsorshipHistoryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configure(with: model)
                return cell
        })
    }
}

extension SponsorshipHistoryViewController: ViewModelBindable {
    typealias ViewModel = SponsorshipHistoryViewModel

    func bindViewModel(viewModel: ViewModel) {
        let dataSource = configureDataSource()

        tableView.addInfiniteScroll { [weak self] tableView in
            self?.viewModel?.loadTrigger.onNext(())
            self?.tableView.finishInfiniteScroll()
        }
        tableView.setShouldShowInfiniteScrollHandler { [weak self] _ in
            return self?.viewModel?.shouldInfiniteScroll ?? false
        }

        let input = SponsorshipHistoryViewModel.Input(
            viewWillAppear: rx.viewWillAppear.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .viewWillAppear
            .drive(onNext: { [weak self] in
                self?.navigationController?.navigationBar.prefersLargeTitles = false
            })
            .disposed(by: disposeBag)

        output
            .sponsorshipList
            .drive { $0 }
            .map { [SectionModel(model: "", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

//        output
//            .activityIndicator
//            .drive(onNext: { [weak self] status in
//                if status {
//                    self?.view.makeToastActivity(.center)
//                } else {
//                    self?.view.hideToastActivity()
//                }
//            })
//            .disposed(by: disposeBag)
    }
}
