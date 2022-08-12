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
        //let viewModel = BreedsListViewModel(dogService: DogBreedsApi)
        let breedsListViewController = BreedsListViewController(nibName: BreedsListViewController.identifier, bundle: nil)

        self.navigationController.viewControllers = [breedsListViewController]
    }
}
