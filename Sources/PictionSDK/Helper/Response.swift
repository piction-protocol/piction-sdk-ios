//
//  Response.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public enum Response<T: Mappable> {
    case success(T)
    case failure(ErrorModel)
}
