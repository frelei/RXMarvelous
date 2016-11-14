//
//  HeroTableViewCell.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 06/11/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import UIKit
import RxSwift

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    
    var disposeBag: DisposeBag?
    
    var downloadableImage: Observable<UIImage>? {
        didSet {
            let disposeBag = DisposeBag()
            
            self.downloadableImage?
                .observeOn(MainScheduler.instance)
                .bindTo(heroImageView.rx.image(transitionType: kCATransitionFade))
                .addDisposableTo(disposeBag)
    
            self.disposeBag = disposeBag
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImageView.image = nil
        heroNameLabel.text = nil
        disposeBag = nil
    }
    
}
