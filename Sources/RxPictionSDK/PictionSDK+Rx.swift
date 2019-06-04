//
//  PictionSDK+Rx.swift
//  RxPictionSDK
//
//  Created by jhseo on 03/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya
import Mapper
import RxSwift
#if !COCOAPODS
    import PictionSDK
#endif

extension PictionSDK: ReactiveCompatible {}

public extension Reactive where Base: PictionSDK {
    func requestAPI<M: Mappable, T: TargetType>(_ target: T) -> Observable<M> {
        return Observable<M>.create({ observer -> Disposable in
            PictionSDK.requestAPI(target,
                success: { (response: M) in
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
