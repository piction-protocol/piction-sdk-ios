//
//  SubscriptionListViewController.swift
//  PictionView
//
//  Created by jhseo on 25/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable
import RxDataSources
import UIScrollView_InfiniteScroll
import PictionSDK

final class SubscriptionListViewController: UIViewController {
    var disposeBag = DisposeBag()

    var emptyView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 350))

    @IBOutlet weak var collectionView: UICollectionView!

    private func openProjectViewController(uri: String) {
        let vc = ProjectViewController.make(uri: uri)
        if let topViewController = UIApplication.topViewController() {
            topViewController.openViewController(vc, type: .push)
        }
    }

    private func embedCustomEmptyViewController(style: CustomEmptyViewStyle) {
        _ = emptyView.subviews.map { $0.removeFromSuperview() }
        emptyView.frame.size.height = 350
        let vc = CustomEmptyViewController.make(style: style)
        embed(vc, to: emptyView)
    }

    private func configureDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, ProjectModel>> {
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, ProjectModel>>(
            configureCell: { dataSource, collectionView, indexPath, model in
                let cell: SubscriptionListCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configure(with: model)
                return cell
        },
        configureSupplementaryView: { [weak self] (dataSource, collectionView, kind, indexPath) in
            guard let `self` = self else { return UICollectionReusableView() }
            if (kind == UICollectionView.elementKindSectionHeader) {
                let reusableView = collectionView.dequeueReusableView(SubscriptionListCollectionHeaderView.self, indexPath: indexPath, kind: .header)
                return reusableView
            } else if (kind == UICollectionView.elementKindSectionFooter) {
                let reusableView = collectionView.dequeueReusableView(SubscriptionListCollectionFooterView.self, indexPath: indexPath, kind: .footer)

                _ = reusableView.subviews.map { $0.removeFromSuperview() }
                reusableView.addSubview(self.emptyView)
                return reusableView
            }
            return UICollectionReusableView()
        })
    }
}

extension SubscriptionListViewController: ViewModelBindable {
    typealias ViewModel = SubscriptionListViewModel

    func bindViewModel(viewModel: ViewModel) {
        let dataSource = configureDataSource()

        collectionView.addInfiniteScroll { [weak self] tableView in
            self?.viewModel?.loadTrigger.onNext(())
            self?.collectionView.finishInfiniteScroll()
        }
        collectionView.setShouldShowInfiniteScrollHandler { [weak self] _ in
            return self?.viewModel?.shouldInfiniteScroll ?? false
        }

        let input = SubscriptionListViewModel.Input(
            viewWillAppear: rx.viewWillAppear.asDriver(),
            viewWillDisappear: rx.viewWillDisappear.asDriver(),
            selectedIndexPath:
            collectionView.rx.itemSelected.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .viewWillAppear
            .drive(onNext: { [weak self] _ in
                self?.navigationController?.showTransparentNavigationBar()
                self?.navigationController?.navigationBar.tintColor = UIView().tintColor
                self?.navigationController?.setNavigationBarLine(false)
                self?.navigationController?.navigationBar.prefersLargeTitles = true
            })
            .disposed(by: disposeBag)

        output
            .viewWillDisappear
            .drive(onNext: { [weak self] _ in
                self?.navigationController?.hideTransparentNavigationBar()
                self?.navigationController?.setNavigationBarLine(true)
                self?.navigationController?.navigationBar.prefersLargeTitles = false
            })
            .disposed(by: disposeBag)

        output
            .subscriptionList
            .do(onNext: { [weak self] _ in
                _ = self?.emptyView.subviews.map { $0.removeFromSuperview() }
                self?.emptyView.frame.size.height = 0
            })
            .drive { $0 }
            .map { [SectionModel(model: "", items: $0)] }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        output
            .embedEmptyViewController
            .drive(onNext: { [weak self] style in
                guard let `self` = self else { return }
                self.embedCustomEmptyViewController(style: style)
            })
            .disposed(by: disposeBag)

        output
            .openProjectViewController
            .drive(onNext: { [weak self] project in
                self?.openProjectViewController(uri: project.uri ?? "")
            })
            .disposed(by: disposeBag)
    }
}

extension SubscriptionListViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.emptyView.subviews.count > 0 {
            return CGSize(width: SCREEN_W, height: 350)
        } else {
            return CGSize.zero
        }
    }
}
