//
//  BreedsListViewController.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 12/08/22.
//

import Foundation
import UIKit

class BreedsListViewController: UIViewController {
    static let identifier = "BreedsListViewController"
    let viewModel: BreedsListViewModel
    
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
    }
    
}
