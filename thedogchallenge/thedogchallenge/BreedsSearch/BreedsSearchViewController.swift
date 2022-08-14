//
//  BreedsSearchViewController.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation
import UIKit
class BreedsSearchViewController: UIViewController {
    var viewModel: BreedsSearchViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.searchBreeds()
    }
    
}
