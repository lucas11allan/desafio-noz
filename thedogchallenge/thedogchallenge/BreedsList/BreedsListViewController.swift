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
    
    let viewModel: BreedsListViewModel
    
    private var isListView = true
    
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
        
        viewModel.getImages()
        setupNavigationBar()
        setUpTableView()
    }
    
    func setupNavigationBar() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self,
                                                            action: #selector(search))
        let filterButton = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                            action: #selector(openFilter))
        let backButton = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: nil)

        /*searchButton.tintColor = .white
        filterButton.tintColor = .white
        backButton.tintColor = .white*/

        navigationItem.rightBarButtonItems = [filterButton, searchButton]
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "The Dogs"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @objc func openFilter() {
        isListView = !isListView
    }

    @objc func search() {
        //searchBar.isHidden = searchBar.isHidden ? false : true
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: BreedTableViewCell.identifier, bundle: nil),
                              forCellReuseIdentifier: BreedTableViewCell.identifier)
        
        viewModel.images
            .bind(to: tableView.rx.items(
                cellIdentifier: BreedTableViewCell.identifier, cellType: BreedTableViewCell.self)) { idx, breed, cell in
                    cell.setData(breed: breed)
                    //cel.updateColor(type: idx % 2 == 0 ? .black : .white)
                    //cel.repositoryLabel.text = repo.name
                    
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(BreedDetail.self)
            .subscribe { breed in
                self.viewModel.openDetails(breed: breed)
            }
          .disposed(by: disposeBag)
    }
    
}
