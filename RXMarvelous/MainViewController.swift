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

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    
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
        }.addDisposableTo(disposeBag)
        
        
        // TableView Delegates
        tableView.rx.contentOffset
            .subscribe { _ in
                if self.searchBar.isFirstResponder {
                    _ = self.searchBar.resignFirstResponder()
                }
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx
            .itemSelected
            .subscribe(onNext: { indexPath in
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
            .addDisposableTo(disposeBag)
        
        tableView.rx.modelSelected(Character.self)
            .subscribe { (character) in
                self.performSegue(withIdentifier: "MarvelDetail", sender: character.element)
            }.addDisposableTo(disposeBag)
        
        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MarvelDetailViewController {
            let char = sender as? Character
            viewController.character = char
        }
    }
    
}


extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
