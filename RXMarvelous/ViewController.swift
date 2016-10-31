//
//  ViewController.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 30/10/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CharacterAPI.request(endpoint: .characters(nameStartsWith: "Thor", limit: 20, offset: 0))

            .subscribe { (event: Event<[Character]>) in
                switch event {
                case .next(let character):
                    print(character)
                    
                case .completed:
                    print("Completed")
                    
                case .error(let e):
                    print(e.localizedDescription)
                  
                }
        }.addDisposableTo(dispose)
    
    }
    
}
