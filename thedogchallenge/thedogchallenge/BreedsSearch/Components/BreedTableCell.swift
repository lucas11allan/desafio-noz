//
//  BreedTableCell.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 14/08/22.
//

import Foundation
import UIKit

class BreedTableCell: UITableViewCell {
    static let identifier = "BreedTableCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(breed: Breed) {
        nameLabel.text = breed.name ?? "--"
    }
}
