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
    
    // MARK: - Initializers
    class func mappedArrayOfCharacter(dict: Dictionary<String, AnyObject>?) -> [Character] {
        if let dictionary = dict?["data"] as? [String:Any],
            let values = dictionary["results"] as? [[String:Any]],
            let characters = Mapper<Character>().mapArray(JSONArray: values) {
                return characters
        } else {
            return []
        }
    }
    
    required convenience init?(map: Map) {
         self.init()
    }
    
    func mapping(map: Map) {
        characterId <- map["id"]
        name <- map["name"]
        description <- map["description"]
        modified <- map["modified"]
        thumbnail <- map["thumbnail"]
    }
    
    // MARK: - function
    
    func getHeroImagePath() -> String {
        if let thumb = thumbnail,
            let path = thumb["path"],
            let ext = thumb["extension"] {
            return "\(path).\(ext)"
        } else {
            return  ""
        }
    }
}
