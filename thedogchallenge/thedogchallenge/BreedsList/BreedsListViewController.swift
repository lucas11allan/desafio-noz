//
//  BreedsListViewController.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 12/08/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BreedsListViewController: UIViewController {
    static let identifier = "BreedsListViewController"
    private let disposeBag = DisposeBag()
    private let order = [0: "RANDOM", 1: "ASC", 2: "DESC"]
    let viewModel: BreedsListViewModel
    private var isListView = true
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: BreedsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setUpTableView()
        
        segmentedControl.rx.selectedSegmentIndex.subscribe (onNext: { param in
            guard let order = self.order[param] else { return }
            self.viewModel.getImages(order: order)
        })
        .disposed(by: disposeBag)
    }
    
    func setupNavigationBar() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self,
                                                            action: #selector(search))

        /*searchButton.tintColor = .white*/

        navigationItem.rightBarButtonItems = [searchButton]
        navigationItem.title = "The Dogs"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    @objc func search() {
        viewModel.goToSearch()
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: BreedTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: BreedTableViewCell.identifier)
        
        viewModel.images
            .bind(to: tableView.rx.items(
                cellIdentifier: BreedTableViewCell.identifier, cellType: BreedTableViewCell.self)) { idx, breed, cell in
                    cell.setData(breed: breed)
                }
                .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(BreedImage.self)
            .subscribe { breed in
                self.viewModel.openDetails(breed: breed)
            }
            .disposed(by: disposeBag)
    }
    
}
