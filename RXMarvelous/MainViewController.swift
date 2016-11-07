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
    
    private let disposeBag = DisposeBag()
    private let mainViewModel = MainViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "HeroTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HERO_CELL")
        mainViewModel.heros.bindTo(tableView.rx.items(cellIdentifier: "HERO_CELL")) { row, character, herocell in
            let cell: HeroTableViewCell = (herocell as? HeroTableViewCell)!
            cell.heroNameLabel.text = character.name
            
        }.addDisposableTo(disposeBag)
        
        
    }

}
