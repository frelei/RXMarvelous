//
//  UIKitExtension.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 13/11/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import Foundation
import RxSwift



extension UIImage {
    
    static func imageFrom(urlString: String) -> Observable<UIImage> {
        return Observable.deferred { () -> Observable<UIImage> in
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request).flatMap { data in
                     Observable.just(UIImage(data: data)! )
                }
            } else {
               return Observable.just(UIImage())
            }
            
        }
    }
    
}
