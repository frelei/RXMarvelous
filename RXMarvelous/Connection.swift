//
//  Connection.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 06/11/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol Resource {
    
    var baseURL: String {get}
    var path: String {get}
    var method: Alamofire.HTTPMethod {get}
    var parameter: [String:AnyObject]? {get}
    
}

struct Connection {

    static func request(endpoint: Resource) -> Observable<[String:AnyObject]> {
        return Observable.create { observer in
            let request = Alamofire.request(endpoint.path,
                                            method: endpoint.method,
                                            parameters: endpoint.parameter)
                .validate()
                .responseJSON { (response: DataResponse<Any>) in
                    if let err = response.result.error {
                        observer.onError(err)
                    } else {
                        if let result = response.result.value as? [String:AnyObject] {
                            observer.onNext(result)
                        }
                        observer.onCompleted()
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}
