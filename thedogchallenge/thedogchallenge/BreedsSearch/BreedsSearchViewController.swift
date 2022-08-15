//
//  BreedsSearchViewController.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation
import UIKit
import RxSwift

class BreedsSearchViewController: UIViewController {
    var viewModel: BreedsSearchViewModel?
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.searchBreeds()
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: BreedTableCell.identifier, bundle: nil),
                           forCellReuseIdentifier: BreedTableCell.identifier)
        
        viewModel?.breeds
            .bind(to: tableView.rx.items(
                cellIdentifier: BreedTableCell.identifier, cellType: BreedTableCell.self)) { idx, breed, cell in
                    cell.setData(breed: breed)
                }
                .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Breed.self)
            .subscribe { breed in
                self.viewModel?.openDetails(breed: breed)
            }
            .disposed(by: disposeBag)
    }
    
}
