//
//  MainViewModel.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 06/11/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import Foundation
import RxSwift

class MainViewModel {
    
    let heros: Observable<[Character]>
    
    init() {
        heros = Connection.request(endpoint: CharacterAPI.Endpoints.characters(nameStartsWith: nil, limit: 20, offset: 0))
        // Transform the json objects in Characters
        .map {
              Character.mappedArrayOfCharacter(dict: $0)
         }
         // Make sure the events are delivered in the main thread
        .observeOn(MainScheduler.instance)
    }
    
}
