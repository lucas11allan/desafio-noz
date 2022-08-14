//
//  DogDetailViewController.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BreedDetailViewController: UIViewController {
    static let identifier = "BreedDetailViewController"
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var orignLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    
    var viewModel: BreedDetailViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else { return }
        setData(viewModel)
    }
    
    private func setData(_ viewMoel: BreedDetailViewModel) {
        guard let breedInfo = viewMoel.breed.breeds?[0] else { return }
        nameLabel.text = breedInfo.name
        categoryLabel.text = breedInfo.breed_group
        orignLabel.text = breedInfo.breed_for
        temperamentLabel.text = breedInfo.temperament
        
        guard let urlString = viewMoel.breed.url else { return }
        let url = URL(string: urlString)
        dogImageView.kf.setImage(with: url)
    }
}
