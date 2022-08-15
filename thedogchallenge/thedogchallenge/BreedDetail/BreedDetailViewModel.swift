//
//  DogDetailViewModel.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation

class BreedDetailViewModel {
    private let service: DogBreedsApi
    private let coordinator: AppCoordinator
    var breedDetail: DogDetailModel
    
    init(service: DogBreedsApi, coordinator: AppCoordinator, breed: BreedImage) {
        self.service = service
        self.coordinator = coordinator
        self.breedDetail = DogDetailModel(breed: breed)
    }
}
