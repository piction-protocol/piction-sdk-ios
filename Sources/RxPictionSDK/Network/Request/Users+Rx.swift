//
//  Users+Rx.swift
//  RxPictionSDK
//
//  Created by jhseo on 03/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import RxSwift

extension Users: ReactiveCompatible {}

public extension Reactive where Base: Users {
    func me() -> Observable<CurrentUserResponse> {
        return Observable<CurrentUserResponse>.create({ observer -> Disposable in
            self.base.me(
                success: { (response: CurrentUserResponse) in
                    observer.onNext(response)
                    observer.onCompleted()
                },
                failure: { error in
                    observer.onError(error)
                })
            return Disposables.create()
        })
    }
}
