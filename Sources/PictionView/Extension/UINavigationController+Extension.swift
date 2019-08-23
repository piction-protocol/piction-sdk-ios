//
//  UINavigationController+Extension.swift
//  PictionView
//
//  Created by jhseo on 04/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit

extension UINavigationController {

    public func showTransparentNavigationBar() {
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = UIColor.white
        //        not work in iOS 11.0
        //        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.clear]

    }

    public func showBlurNavigationBar() {
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = UIColor.white
        //        not work in iOS 11.0
        //        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.clear]

    }

    public func hideTransparentNavigationBar() {
        navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for: UIBarMetrics.default)
        navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
        navigationBar.tintColor = UIView().tintColor
        //        not work in iOS 11.0
        //        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
    }

    public func disableNavigationBar() {
        navigationBar.tintColor = UIColor.init(r: 170, g: 0, b: 255, a: 0.3)
        navigationBar.isUserInteractionEnabled = false
    }

    public func enableNavigationBar() {
        navigationBar.tintColor = UIColor.blue
        navigationBar.isUserInteractionEnabled = true
    }

    public func setNavigationBarLine(_ show: Bool) {
        if show {
            navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for: UIBarMetrics.default)
            navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
        } else {
            navigationBar.setBackgroundImage(UIImage().imageWithColor(color: .white), for: UIBarMetrics.default)
            navigationBar.shadowImage = UIImage()
        }
    }
}

