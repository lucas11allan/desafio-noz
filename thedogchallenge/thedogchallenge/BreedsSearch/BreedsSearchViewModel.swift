//
//  BreedsSearchViewModel.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation
import RxSwift
protocol BreedsSearchViewModelProtocol {
    var service: ServiceDogProtocol { get }
    var breeds: BehaviorSubject<[Breed]> { get }
    var coordinator: AppCoordinator { get }
    
    func searchBreeds(query: String)
    func openDetails(breed: Breed)
}

class BreedsSearchViewModel: BreedsSearchViewModelProtocol {
    internal let service: ServiceDogProtocol
    private var currentPage: Int = 0
    private var hasEnded: Bool = false
    private var error: String = ""
    private var isLoading: Bool = false
    let breeds = BehaviorSubject<[Breed]>(value: [])
    internal let coordinator: AppCoordinator
    
    init(service: ServiceDogProtocol, coordinator: AppCoordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func searchBreeds(query: String) {
        service.fetchSearchBreeds(query: query, page: currentPage) { [weak self] result in
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
        guard let id = breed.reference_image_id else { return }
        service.fetchImage(id: id) { [weak self] result in
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
