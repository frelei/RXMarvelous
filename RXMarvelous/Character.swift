//
//  Character.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 31/10/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import Foundation
import ObjectMapper

class Character: Mappable {
    
    var characterId: Int?
    var name: String?
    var description: String?
    var modified: String?
    var url: [String]?
    var thumbnail: [String:String]?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        characterId <- map["id"]
        name <- map["name"]
        description <- map["description"]
        modified <- map["modified"]
        thumbnail <- map["thumbnail"]
    }
    
}
