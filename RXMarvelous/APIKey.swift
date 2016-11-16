//
//  APIKey.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 30/10/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import Foundation

struct APIKey {
   
   // MARK: - Add your keys here
   static let PUBLICKEY = ""
   static let PRIVATEKEY = ""
    
    static func authentication() -> [String:String] {
        let actualTime = NSDate().timeIntervalSince1970.description
        let hash = String.md5("\(actualTime)\(APIKey.PRIVATEKEY)\(APIKey.PUBLICKEY)")
        return ["apikey":PUBLICKEY, "ts": actualTime, "hash": hash] 
    }
}
