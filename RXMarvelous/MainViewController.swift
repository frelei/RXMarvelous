//
//  MainViewController.swift
//  RXMarvelous
//
//  Created by Rodrigo Leite on 06/11/16.
//  Copyright © 2016 frelei. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Trigger when reach the bottom of the tableView
        let trigger = tableView.rx.contentOffset.flatMap { _ in
            (self.tableView.contentOffset.y + self.tableView.frame.size.height + 20 > self.tableView.contentSize.height)
                ? Observable.just()
                : Observable.empty()
        }
        
        let searchResult = searchBar.rx.text.asObservable()
                            .throttle(3, scheduler: MainScheduler.instance)
                            .flatMapLatest { query -> Observable<[Character]> in
                                return CharacterAPI().heros(search: query!, trigger: trigger)
                            }.catchErrorJustReturn([Character]())
        
        // Configure the tableview cell
        let nib = UINib(nibName: "HeroTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HERO_CELL")
        searchResult.bindTo(tableView.rx.items(cellIdentifier: "HERO_CELL")) { row, character, herocell in
            let cell: HeroTableViewCell = (herocell as? HeroTableViewCell)!
            cell.heroNameLabel.text = character.name
            cell.downloadableImage = UIImage.imageFrom(urlString: character.getHeroImagePath())
//            UIImage.imageFrom(urlString: character.getHeroImagePath())
//                .bindTo(cell.heroImageView.rx.image(transitionType: kCATransitionFade))
//                .addDisposableTo(self.disposeBag)

            }.addDisposableTo(disposeBag)
        
        
        tableView.rx.contentOffset
            .subscribe { _ in
                if self.searchBar.isFirstResponder {
                    _ = self.searchBar.resignFirstResponder()
                }
            }
            .addDisposableTo(disposeBag)
    }

}
