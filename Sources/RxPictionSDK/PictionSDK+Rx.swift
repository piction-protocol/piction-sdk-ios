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

public extension Reactive {
    static func requestAPI<T: TargetType>(_ target: T) -> Observable<Moya.Response> {
        return Observable.create({ observer -> Disposable in
            request(target,
                success: { response in
                    observer.onNext(response)
                    observer.onCompleted()
                }, failure: { error in
                    observer.onError(error)
                })
            return Disposables.create()
        })
    }

    private static func request<T: TargetType>(_ target: T, success successCompletion: @escaping (Moya.Response) -> Void, failure failureCompletion: @escaping (ErrorType) -> Void) {
        let provider = MoyaProvider<T>()

        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    try response.filterStatusCode()
                    if T.self == SessionsAPI.self {
                        let token = try response.map(to: AuthenticationViewResponse.self)
                        PictionManager.setToken(token.accessToken ?? "")
                    }
                    successCompletion(response)
                } catch {
                    if let error = error as? ErrorType {
                        failureCompletion(error)
                    }
                }
            case let .failure(error):
                print("Request Error: \(error)")
            }
        }
    }
}
