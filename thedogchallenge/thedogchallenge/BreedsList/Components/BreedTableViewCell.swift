//
//  BreedTableViewCell.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 14/08/22.
//

import Foundation
import UIKit
import Kingfisher

class BreedTableViewCell: UITableViewCell {
    static let identifier = "BreedTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearUI()
    }
    
    private func clearUI() {
        titleLabel.text = "--"
        self.breedImage.image = UIImage(systemName: "arrow.clockwise")
    }
    
    func setData(breed: BreedImage) {
        if breed.breeds?.count != 0 {
            titleLabel.text = breed.breeds?[0].name ?? "--"
        } else {
            titleLabel.text = "--"
        }
        
        if let url = breed.url {
            downloadImage(url: url)
        }
    }
    
    func downloadImage(url: String) {
        let url = URL(string: url)
        breedImage.kf.setImage(with: url)
    }
}
