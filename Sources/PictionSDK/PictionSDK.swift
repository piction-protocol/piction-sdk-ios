//
//  PictionSDK.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya
import Mapper

public final class PictionSDK {
    public static let users: Users = Users.shared
    public static let sessions: Sessions = Sessions.shared
    public static let projects: Projects = Projects.shared

    public init() {}

    public class func requestAPI<M: Mappable, T: TargetType>(_ target: T, success successCompletion: ((M) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(target,
            success: { (response: M) in
                if T.self == SessionsAPI.self {
                    let token = response as? AuthenticationResponse
                    PictionManager.setToken(token?.accessToken ?? "")
                }
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}
//
//import RxSwift
//
//extension PictionSDK: ReactiveCompatible {}
//
//public extension Reactive where Base: PictionSDK {
//    func requestAPI<M: Mappable, T: TargetType>(_ target: T) -> Observable<M> {
//        return Observable<M>.create({ observer -> Disposable in
//            PictionSDK.requestAPI(target,
//                                  success: { (response: M) in
//                                    observer.onNext(response)
//                                    observer.onCompleted()
//            },
//                                  failure: { error in
//                                    observer.onError(error)
//            })
//            return Disposables.create()
//        })
//    }
//}
