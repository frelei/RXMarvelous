//
//  XCTestExtension.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 06/11/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import RXMarvelous

extension XCTestCase {
    
    func stub(file: String, url: String, statusCode: Int32) {
        let jsonFile = "\(file).json"
        createStub(with: url, file: jsonFile, statusCode: statusCode)
    }
    
    fileprivate func createStub(with path: String, file: String, statusCode: Int32) {
        
        OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return path == request.url!.path
        }) { (request: URLRequest) -> OHHTTPStubsResponse in
            let stubPath = OHPathForFile(file, type(of: self))!
            return OHHTTPStubsResponse(fileAtPath: stubPath, statusCode: statusCode, headers: ["Content-Type":"application/json"])
            }.name = file
        
        OHHTTPStubs.onStubActivation { (request: URLRequest, stub: OHHTTPStubsDescriptor, response: OHHTTPStubsResponse) in
            print("\(request.url!) stubbed by \(stub.name!).")
            OHHTTPStubs.removeStub(stub)
        }
        
    }
    
}
