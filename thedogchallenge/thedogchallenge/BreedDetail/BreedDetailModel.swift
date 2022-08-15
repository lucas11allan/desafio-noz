//
//  DogDetailModel.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation
import UIKit
import Kingfisher

struct DogDetailModel {
    var imageUrl: String
    var name: String
    var category: String
    var origin: String
    var temperament: String
    
    init(breed: Breed, imageUrl: String) {
        self.name = breed.name ?? "--"
        self.category = breed.breed_group ?? "--"
        self.origin = breed.life_span ?? "--"
        self.temperament = breed.temperament ?? "--"
        self.imageUrl = imageUrl
    }
    
    init(breed: BreedImage) {
        let breedInfo = breed.breeds?[0]
        self.name = breedInfo?.name ?? "--"
        self.category = breedInfo?.breed_group ?? "--"
        self.origin = breedInfo?.life_span ?? "--"
        self.temperament = breedInfo?.temperament ?? "--"
        self.imageUrl = breed.url ?? "--"
    }
}
