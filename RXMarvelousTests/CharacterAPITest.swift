//
//  CharacterAPITest.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 06/11/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import XCTest
import RxSwift

@testable import RXMarvelous

class CharacterAPITest: XCTestCase {
    

    func testValidConnection() {
        
        stub(file: "character", url: "https://gateway.marvel.com/v1/public/characters?apikey=ddde9d0314a3aaa4e2ca8ef07168ac13&hash=a97c3bec57c97a5bc792fc91438d61e8&limit=2&offset=0&ts=1478475687.0453", statusCode: 200)
        
        let expectation = self.expectation(description: "completed")
        let observable = Connection.request(endpoint: CharacterAPI.Endpoints.characters(nameStartsWith: nil, limit: 2, offset: 0))
        observable.subscribe { (event: Event<[String : AnyObject]>) in
            switch event {
                case .next( _):
                    XCTAssertTrue(true)
                case .completed:
                    XCTAssertTrue(true)
                case .error( _):
                    XCTFail("Should be success")
            }
            expectation.fulfill()
        }.addDisposableTo(DisposeBag())
        
        
        waitForExpectations(timeout: 60, handler: nil)
        
    }
    
}
