//
//  DogsListViewModel.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation
import RxSwift

class BreedsListViewModel: ObservableObject {
    private let service: DogBreedsApi
    
    var currentPage: Int = 0

    var hasEnded: Bool = false

    var error: String = ""
    
    @Published var images = [BreedImage]()
    @Published var isLoading: Bool = false
    
    init(service: DogBreedsApi) {
        self.service = service
    }
    
    func getImages(_ page: Int = 1) {
        service.fetchImages(page: page) { [weak self] result in
            switch result {
            case .success(let data):
                self?.isLoading = false
                self?.images = data
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

