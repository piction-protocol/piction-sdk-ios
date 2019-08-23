//
//  AppInfo.swift
//  PictionView
//
//  Created by jhseo on 20/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit

let SCREEN_W = UIScreen.main.bounds.size.width
let SCREEN_H = UIScreen.main.bounds.size.height
let IS_IPHONEX = (SCREEN_W == 375 && SCREEN_H == 812)
let IS_IPHONEXR = (SCREEN_W == 414 && SCREEN_H == 896)
let NAVIGATION_HEIGHT: CGFloat = (IS_IPHONEX || IS_IPHONEXR) ? 88 : 64
