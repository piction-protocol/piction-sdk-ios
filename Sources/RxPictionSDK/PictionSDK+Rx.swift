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
                    print("\(type(of: target)).\(target)")
                    print(response)
                    try response.filterStatusCode()

                    let responseJSON = try? response.mapJSON() as? [String : Any?]
                    if let token = responseJSON?["accessToken"] as? String {
                        PictionManager.setToken(token)
                    }
                    successCompletion(response)
                } catch {
                    print(error)
                    if let error = error as? ErrorType {
                        failureCompletion(error)
                    } else {
                        let errorItem: [String: Any] = [
                            "code": response.statusCode,
                            "status_code": response.statusCode,
                            "message": response.description
                        ]
                        let errorModel = ErrorModel.from(NSDictionary(dictionary: errorItem))!
                        let errorType = ErrorType.custom(errorModel)

                        failureCompletion(errorType)
                    }
                }
            case let .failure(error):
                print("Request Error: \(error)")
                let errorItem: [String: Any] = [
                    "code": error.errorCode,
                    "status_code": error.errorCode,
                    "message": error.localizedDescription
                ]
                let errorModel = ErrorModel.from(NSDictionary(dictionary: errorItem))!
                let errorType = ErrorType.custom(errorModel)
                failureCompletion(errorType)
            }
        }
    }
}
