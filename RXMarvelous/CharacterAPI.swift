//
//  CharacterAPI.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 30/10/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift


struct CharacterAPI {
    
    static func request<T>(endpoint: CharacterAPI.Endpoints) -> Observable<[T]> {
        return Observable.create { observer in
            let request = Alamofire.request(endpoint.path,
                                        method: endpoint.method,
                                        parameters: endpoint.parameter,
                                        encoding: JSONEncoding.default,
                                        headers: nil)
            .validate()
            .responseJSON { (response: DataResponse<Any>) in
                if let err = response.result.error {
                    observer.onError(err)
                } else {
                    if let elements = response.result.value as? [T] {
                        observer.onNext(elements)
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    enum Endpoints {
        case characters(nameStartsWith: String, limit: Int, offset: Int)
        case character(characterId: Int)
        case comic(characterId: Int)
        case event(charactedId: Int)
        case series(characterId: Int)
        case stories(characterId: Int)
        
        var baseURL: String { return "https://gateway.marvel.com:443/v1/public/"}
        
        var method: Alamofire.HTTPMethod {
            switch self {
            case .characters,
                 .character,
                 .comic,
                 .event,
                 .series,
                 .stories:
                return  Alamofire.HTTPMethod.get
            }
        }
        
        var path: String {
            switch self {
            case .characters:
                    return baseURL + "characters"
            case .character(let characterId):
                    return baseURL + "characters/\(characterId)"
            case .comic(let characterId):
                    return baseURL + "characters/\(characterId)"
            case .event(let characterId):
                    return baseURL + "characters/\(characterId)"
            case .series(let characterId):
                    return baseURL + "characters/\(characterId)"
            case .stories(let characterId):
                return baseURL + "characters/\(characterId)"
            }
        }
        
        var parameter: [String:AnyObject]? {
            switch self {
            case .characters(let nameStartsWith, let limit, let offset):
                return ["nameStartsWith":nameStartsWith as AnyObject,
                        "limit": limit as AnyObject,
                        "offset": offset as AnyObject]
                       .combined(other: APIKey.authentication() as Dictionary<String, AnyObject>)
            case .character:
                return nil
            case .comic( _):
                return nil
            case .event( _):
                return nil
            case .series( _):
                return nil
            case .stories( _):
                return nil
            }
        }   
    }
}
