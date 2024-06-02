//
//  Coordinator.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/30/24.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {
    /// Removing a coordinator inside a children. This call is important to prevent memory leak.
    /// - Parameter coordinator: Coordinator that finished.
    func childDidFinish(_ coordinator : Coordinator){
        // Call this if a coordinator is done.
        for (index, child) in childCoordinators.enumerated() {
            if child === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print(self, "start")
        var isA = false
        
        if isA {
            startAViewController()
        } else {
            startBViewController()
        }
    }
    
    func startAViewController() {
        let coordinator = AViewCoordinator(navigationController: navigationController)
        childCoordinators.removeAll()
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func startBViewController() {
        let coordinator = BViewCoordinator(navigationController: navigationController)
        childCoordinators.removeAll()
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
