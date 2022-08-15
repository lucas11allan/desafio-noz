//
//  DogDetailViewModel.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation

protocol BreedDetailViewModelProtocol {
    var breedDetail: DogDetailModel { get }
}

class BreedDetailViewModel: BreedDetailViewModelProtocol {
    private let service: ServiceDogProtocol
    private let coordinator: AppCoordinator
    var breedDetail: DogDetailModel
    
    init(service: ServiceDogProtocol, coordinator: AppCoordinator, breed: BreedImage) {
        self.service = service
        self.coordinator = coordinator
        self.breedDetail = DogDetailModel(breed: breed)
    }
}
