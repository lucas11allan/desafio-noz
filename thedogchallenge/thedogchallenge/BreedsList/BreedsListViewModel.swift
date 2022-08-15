//
//  DogsListViewModel.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation
import RxSwift

protocol BreedsListViewModelProtocol {
    var service: ServiceDogProtocol { get }
    var images: BehaviorSubject<[BreedImage]> { get }
    var coordinator: AppCoordinator { get }
    
    func getImages(order: String)
    func openDetails(breed: BreedImage)
    func goToSearch()
}

class BreedsListViewModel: BreedsListViewModelProtocol {
    internal let service: ServiceDogProtocol
    
    private var currentPage: Int = 0
    private var hasEnded: Bool = false
    private var error: String = ""
    private var isLoading: Bool = false
    let images = BehaviorSubject<[BreedImage]>(value: [])
    
    let coordinator: AppCoordinator
    
    init(service: ServiceDogProtocol, coordinator: AppCoordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func getImages(order: String = "RANDOM") {
        service.fetchImages(page: currentPage, order: order.uppercased()) { [weak self] result in
            switch result {
            case .successImage(let data):
                self?.isLoading = false
                self?.images.onNext(data)
            case .error(let erro):
                self?.error = erro.localizedDescription
                debugPrint("Um erro aconteceu: \(String(describing: self?.error))")
            default:
                self?.error = "No content"
                debugPrint("Um erro aconteceu: \(String(describing: self?.error))")
            }
        }
    }
    
    func openDetails(breed: BreedImage) {
        guard let id = breed.id else { return }
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
    
    func goToSearch() {
        coordinator.openSearchScreen()
    }
}

