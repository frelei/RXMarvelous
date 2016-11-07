//
//  CharacterTest.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 06/11/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import XCTest

class CharacterTest: XCTestCase {

    func testArrayJsonCharacter() {
        let file = Bundle(for: CharacterTest.self).path(forResource: "characters", ofType: "json")
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath:file!))
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let characters = Character.mappedArrayOfCharacter(dict: json as? Dictionary<String, AnyObject>)
            XCTAssertEqual(characters?[0].name, "3-D Man")
            XCTAssertEqual(characters?[0].characterId, 1011334)
            XCTAssert(characters?.count == 2, "Pass")
        } catch {
            XCTFail("Fail not able to serialize json")
        }
    }
    
    
    func testCharacterGetImage() {
        let character = Character(JSON: ["thumbnail":["path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                                                      "extension": "jpg"]])
        XCTAssertEqual(character?.getHeroImagePath(), "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")
    }
    
    
    
}
