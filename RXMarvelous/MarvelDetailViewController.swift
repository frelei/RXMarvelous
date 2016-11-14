//
//  MarvelDetailViewController.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 14/11/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MarvelDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var character: Character?
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = character?.name
        if character?.description != "" {
            descriptionTextView.text = character?.description
        } else {
            descriptionTextView.isHidden = true
        }
        
        UIImage.imageFrom(urlString: character!.getHeroImagePath())
            .observeOn(MainScheduler.instance)
            .bindTo(imageView.rx.image(transitionType: kCATransitionFade))
            .addDisposableTo(dispose)
    }

}
