//
//  APIKey.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 30/10/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import Foundation

struct APIKey {
    
   static let PUBLICKEY = "ddde9d0314a3aaa4e2ca8ef07168ac13"
   static let PRIVATEKEY = "8a42919d6a26e2db6fff5a58a776f8d1f5b88e59"
    
    static func authentication() -> [String:String] {
        let actualTime = NSDate().timeIntervalSince1970.description
        let hash = String.md5("\(actualTime)\(APIKey.PRIVATEKEY)\(APIKey.PUBLICKEY)")
        return ["apikey":PUBLICKEY, "ts": actualTime, "hash": hash] 
    }
}
