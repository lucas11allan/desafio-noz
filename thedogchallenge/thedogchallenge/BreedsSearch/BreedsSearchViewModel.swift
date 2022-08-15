//
//  BreedsSearchViewModel.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation
import RxSwift

class BreedsSearchViewModel {
    private let service: DogBreedsApi
    
    var currentPage: Int = 0

    var hasEnded: Bool = false

    var error: String = ""
    
    var isLoading: Bool = false
    
    let breeds = BehaviorSubject<[Breed]>(value: [])
    
    let coordinator: AppCoordinator
    
    init(service: DogBreedsApi, coordinator: AppCoordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func searchBreeds(_ page: Int = 1) {
        service.fetchSearchBreeds(query: "bull", page: page) { [weak self] result in
            switch result {
            case .successSearch(let data):
                self?.isLoading = false
                self?.breeds.onNext(data)
            case .error(let erro):
                self?.error = erro.localizedDescription
                debugPrint("Um erro aconteceu: \(String(describing: self?.error))")
            default:
                self?.error = "No content"
                debugPrint("Um erro aconteceu: \(String(describing: self?.error))")
            }
        }
    }
    
    func openDetails(breed: Breed) {
        service.fetchImage(id: "rVXxoWhCR") { [weak self] result in
            switch result {
            case .success(let data):
                self?.coordinator.openDetails(breed: data)
            case .error(let erro):
                self?.error = erro.localizedDescription
                debugPrint("Um erro aconteceu: \(String(describing: self?.error))")
            default:
                self?.error = "No content"
                debugPrint("Um erro aconteceu: \(String(describing: self?.error))")
            }
        }
    }
}
