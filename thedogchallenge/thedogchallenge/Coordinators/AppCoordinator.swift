//
//  AppCoordinator.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 12/08/22.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {

    let window: UIWindow
    let dogService: DogBreedsApi

    init(navigationController: UINavigationController, window: UIWindow, dogService: DogBreedsApi) {
        self.window = window
        self.dogService = dogService
        super.init(navigationController: navigationController)
    }

    override func start() {
        let viewModel = BreedsListViewModel(service: dogService, coordinator: self)
        let breedsListViewController = BreedsListViewController(viewModel: viewModel)

        self.navigationController.viewControllers = [breedsListViewController]
    }
    
    func openDetails(breed: BreedImage) {
        let viewModel = BreedDetailViewModel(service: dogService, coordinator: self, breed: breed)
        let detailViewController = BreedDetailViewController()
        detailViewController.viewModel = viewModel
        
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func openDetailsScreen(breed: Breed, url: String) {
        let viewModel = BreedDetailViewModel(service: dogService, coordinator: self, breed: breed, url: url)
        let detailViewController = BreedDetailViewController()
        detailViewController.viewModel = viewModel
        
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func openSearchScreen() {
        let viewModel = BreedsSearchViewModel(service: dogService, coordinator: self)
        let searchViewController = BreedsSearchViewController()
        searchViewController.viewModel = viewModel
        
        self.navigationController.pushViewController(searchViewController, animated: true)
    }
}
