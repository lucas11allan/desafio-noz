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
import Kingfisher

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
    
    private func setData(_ viewModel: BreedDetailViewModel) {
        let breedInfo = viewModel.breedDetail
        nameLabel.text = breedInfo.name
        categoryLabel.text = breedInfo.category
        orignLabel.text = breedInfo.origin
        temperamentLabel.text = breedInfo.temperament
        temperamentLabel.sizeToFit()

        let url = URL(string: breedInfo.imageUrl)
        dogImageView.kf.indicatorType = .activity
        dogImageView.kf.setImage(with: url)
    }
}
