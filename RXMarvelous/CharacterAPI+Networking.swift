//
//  CharacterAPI+Networking.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 13/11/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import Foundation
import RxSwift

extension CharacterAPI {
   
    func heros(from: [Character] = [Character](), search: String, offset: Int = 0, trigger: Observable<Void>) -> Observable<[Character]> {
        return getHeros(from: from, search: search, offset: offset).flatMap { value -> Observable<[Character]> in
            if value.count == 0 {
                return Observable.just(from)
            }
            
            let result = from + value
            return Observable.concat([Observable.just(result),
                                      Observable.never().takeUntil(trigger),
                                      self.heros(from: result, search: search, offset: result.count, trigger: trigger)])
            
        }
    }
    
    private func getHeros(from: [Character], search: String, offset: Int) -> Observable<[Character]> {
        return Connection.request(endpoint: CharacterAPI.Endpoints.characters(nameStartsWith: search, limit: 20, offset: offset))
            .map { Character.mappedArrayOfCharacter(dict: $0) }
    }
    
}
