//
//  SearchProjectViewController.swift
//  PictionView
//
//  Created by jhseo on 09/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable
import RxDataSources
import PictionSDK

final class SearchProjectViewController: UITableViewController {
    var disposeBag = DisposeBag()

    private let searchText = PublishSubject<String>()

    @IBOutlet weak var emptyView: UIView!

    private func configureDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, ProjectModel>> {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ProjectModel>>(
            configureCell: { dataSource, tableView, indexPath, model in

                let cell: SearchProjectTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configure(with: model)
                return cell
        })
        return dataSource
    }

    private func openProjectViewController(uri: String) {
        let vc = ProjectViewController.make(uri: uri)
        if let topViewController = UIApplication.topViewController() {
            topViewController.openViewController(vc, type: .push)
        }
    }

    private func embedCustomEmptyViewController(style: CustomEmptyViewStyle) {
        _ = emptyView.subviews.map { $0.removeFromSuperview() }
        emptyView.frame.size.height = getVisibleHeight()
        let vc = CustomEmptyViewController.make(style: style)
        embed(vc, to: emptyView)
    }
}

extension SearchProjectViewController: ViewModelBindable {
    typealias ViewModel = SearchProjectViewModel

    func bindViewModel(viewModel: ViewModel) {
        let dataSource = configureDataSource()

        tableView.addInfiniteScroll { [weak self] tableView in
            self?.viewModel?.loadTrigger.onNext(())
            self?.tableView.finishInfiniteScroll()
        }
        tableView.setShouldShowInfiniteScrollHandler { [weak self] _ in
            return self?.viewModel?.shouldInfiniteScroll ?? false
        }

        let input = SearchProjectViewModel.Input(
            viewWillAppear: rx.viewWillAppear.asDriver(),
            searchText: searchText.asDriver(onErrorDriveWith: .empty()).throttle(0.5),
            selectedIndexPath: tableView.rx.itemSelected.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .viewWillAppear
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.navigationController?.setNavigationBarHidden(false, animated: false)

//                if self.searchBar.text == "" {
//                    self.searchBar.becomeFirstResponder()
//                }
                //                self?.navigationController?.setNavigationBarLine(false)
            })
            .disposed(by: disposeBag)

        output
            .projectList
            .do(onNext: { [weak self] _ in
                _ = self?.emptyView.subviews.map { $0.removeFromSuperview() }
                self?.emptyView.frame.size.height = 0
            })
            .drive { $0 }
            .map { [SectionModel(model: "", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        output
            .openProjectViewController
            .drive(onNext: { [weak self] indexPath in
                if let item: ProjectModel = try? self?.tableView.rx.model(at: indexPath) {
                    self?.openProjectViewController(uri: item.uri ?? "")
                }
            })
            .disposed(by: disposeBag)

        output
            .embedEmptyViewController
            .drive(onNext: { [weak self] style in
                guard let `self` = self else { return }
                self.embedCustomEmptyViewController(style: style)
            })
            .disposed(by: disposeBag)
    }
}

extension SearchProjectViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.searchText.onNext(text)
    }
}
