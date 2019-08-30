//
//  PostViewController.swift
//  PictionView
//
//  Created by jhseo on 01/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable
import Swinject
import WebKit
import SafariServices
import PictionSDK

final class PostViewController: UIViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var subscriptionView: UIView!
    @IBOutlet weak var subscriptionButton: UIButton!
    @IBOutlet weak var postWebView: WKWebView! {
        didSet {
            postWebView.navigationDelegate = self
            postWebView.scrollView.delegate = self
        }
    }
    @IBOutlet weak var prevPostButton: UIBarButtonItem!
    @IBOutlet weak var nextPostButton: UIBarButtonItem!
    @IBOutlet weak var shareBarButton: UIBarButtonItem!

    private func embedPostHeaderViewController(postItem: PostModel, userInfo: UserModel) {
        for subview in postWebView.scrollView.subviews {
            if subview.tag == 1000 || subview.tag == 1001 {
                subview.removeFromSuperview()
            }
        }
        let vc = PostHeaderViewController.make(postItem: postItem, userInfo: userInfo)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 220))
        containerView.tag = 1000
        embed(vc, to: containerView)
        self.postWebView.scrollView.addSubview(containerView)
    }

    private func embedPostFooterViewController(uri: String, postId: Int, height: CGFloat) {
        //        postWebView.scrollView.subviews.map { $0.removeFromSuperview() }
        let posY = height - 278 //self.postWebView.scrollView.contentSize.height - 300
        let vc = PostFooterViewController.make(uri: uri, postId: postId)
        let containerView = UIView(frame: CGRect(x: 0, y: posY, width: SCREEN_W, height: 278))
        containerView.tag = 1001
        embed(vc, to: containerView)
        self.postWebView.scrollView.addSubview(containerView)
    }

    private func openSignInViewController() {
        let vc = SignInViewController.make()
        if let topViewController = UIApplication.topViewController() {
            topViewController.openViewController(vc, type: .present)
        }
    }
}

extension PostViewController: ViewModelBindable {
    typealias ViewModel = PostViewModel

    func bindViewModel(viewModel: ViewModel) {

        let input = PostViewModel.Input(
            viewWillAppear: rx.viewWillAppear.asDriver(),
            viewWillDisappear: rx.viewWillDisappear.asDriver(),
            prevPostBtnDidTap: prevPostButton.rx.tap.asDriver().throttle(1, latest: true),
            nextPostBtnDidTap: nextPostButton.rx.tap.asDriver().throttle(1, latest: true),
            subscriptionBtnDidTap: subscriptionButton.rx.tap.asDriver(),
            shareBarBtnDidTap: shareBarButton.rx.tap.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .viewWillAppear
            .drive(onNext: { [weak self] in
                self?.navigationController?.navigationBar.prefersLargeTitles = false
                self?.tabBarController?.tabBar.isHidden = true
//                self?.navigationController?.isToolbarHidden = false
            })
            .disposed(by: disposeBag)

        output
            .viewWillDisappear
            .drive(onNext: { [weak self] in
                self?.tabBarController?.tabBar.isHidden = false
//                self?.navigationController?.isToolbarHidden = true
            })
            .disposed(by: disposeBag)

        output
            .headerInfo
            .drive(onNext: { [weak self] (postItem, userInfo) in
                self?.embedPostHeaderViewController(postItem: postItem, userInfo: userInfo)
                self?.navigationItem.title = postItem.title
            })
            .disposed(by: disposeBag)

        output
            .prevPostIsEnabled
            .drive(onNext: { [weak self] postItem in
                self?.prevPostButton.isEnabled = (postItem.id ?? 0) != 0
            })
            .disposed(by: disposeBag)

        output
            .nextPostIsEnabled
            .drive(onNext: { [weak self] postItem in
                self?.nextPostButton.isEnabled = (postItem.id ?? 0) != 0
            })
            .disposed(by: disposeBag)

        output
            .showPostContent
            .drive(onNext: { [weak self] contentItem in
                let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 100))
                headerView.backgroundColor = UIColor.green

                self?.postWebView.loadHTMLString(contentItem, baseURL: nil)
            })
            .disposed(by: disposeBag)

        output
            .reloadPost
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.subscriptionView.isHidden = true
                self.postWebView.scrollView.isScrollEnabled = true
                self.postWebView.loadHTMLString("", baseURL: nil)
                for subview in self.postWebView.scrollView.subviews {
                    if subview.tag == 1000 || subview.tag == 1001 {
                        subview.removeFromSuperview()
                    }
                }
            })
            .disposed(by: disposeBag)

        output
            .showNeedSubscription
            .drive(onNext: { [weak self] userInfo in
                guard let `self` = self else { return }
                var buttonTitle: String {
                    return userInfo.loginId == nil ? "로그인" : "무료로 구독하기"
                }
                self.subscriptionButton.setTitle(buttonTitle, for: .normal)
                self.subscriptionView.isHidden = false
                self.postWebView.scrollView.isScrollEnabled = false

                for subview in self.postWebView.scrollView.subviews {
                    if subview.tag == 1001 {
                        subview.isHidden = true
                    }
                }
            })
            .disposed(by: disposeBag)

        output
            .openSignInViewController
            .drive(onNext: { [weak self] uri in
                self?.openSignInViewController()
            })
            .disposed(by: disposeBag)

        output
            .sharePost
            .drive(onNext: { url in
                let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: [])

                activityViewController.excludedActivityTypes = [
                    UIActivity.ActivityType.print,
                    UIActivity.ActivityType.assignToContact,
                    UIActivity.ActivityType.saveToCameraRoll,
                    UIActivity.ActivityType.addToReadingList,
                    UIActivity.ActivityType.postToFlickr,
                    UIActivity.ActivityType.postToVimeo,
                    UIActivity.ActivityType.openInIBooks
                ]

                if let topController = UIApplication.topViewController() {
                    if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
                        activityViewController.modalPresentationStyle = .popover
                        if let popover = activityViewController.popoverPresentationController {
                            popover.permittedArrowDirections = .up
                            popover.sourceView = topController.view
                            popover.sourceRect = CGRect(x: SCREEN_W, y: 64, width: 0, height: 0)
                        }
                    }
                    topController.present(activityViewController, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)


        output
            .activityIndicator
            .drive(onNext: { [weak self] status in
                if status {
                    self?.view.makeToastActivity(.center)
                } else {
                    self?.view.hideToastActivity()
                }
            })
            .disposed(by: disposeBag)

        output
            .showToast
            .drive(onNext: { message in
                Toast.showToast(message)
            })
            .disposed(by: disposeBag)

        output
            .sharePost
            .drive(onNext: { url in

            })
            .disposed(by: disposeBag)
    }
}

extension PostViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let viewModel = self.viewModel else { return }
        webView.evaluateJavaScript("document.readyState") { (complete, error) in
            if complete != nil {
                webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { [weak self] (height, error) in
                    if self?.subscriptionView.isHidden ?? true {
                        self?.embedPostFooterViewController(uri: viewModel.uri, postId: viewModel.postId, height: height as? CGFloat ?? 0)
                    }
                })
            }
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let requestUrlString = navigationAction.request.url?.absoluteString {
                guard let url = URL(string: requestUrlString) else {
                    decisionHandler(.allow)
                    return }
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil)

                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        } else {
            decisionHandler(.allow)
        }
    }
}

extension PostViewController: UIScrollViewDelegate {
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}
