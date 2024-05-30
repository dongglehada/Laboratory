//
//  Coordinator.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/30/24.
//

import Foundation
import UIKit

struct CoordinatorTestModel {
    let username: String
    let password: String
}

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}

final class CoordinatorLoginSuccessVC: UIViewController {
    
    var viewModel: CoordinatorLoginSuccessViewModel
    
    init(viewModel: CoordinatorLoginSuccessViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

protocol CoordinatorLoginSuccessViewModelDelegate: AnyObject {
    func showVC()
}

final class CoordinatorLoginSuccessViewModel {
    weak var delegate: CoordinatorLoginSuccessViewModelDelegate?
    
    func showVC() {
        delegate?.showVC()
    }
}

final class CoordinatorLoginFailVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

final class CoordinatorTestCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CoordinatorLoginSuccessViewModel()
        let loginVC = CoordinatorLoginSuccessVC(viewModel: viewModel)
        viewModel.delegate = self
    }
}

extension CoordinatorTestCoordinator: CoordinatorLoginSuccessViewModelDelegate {
    func showVC() {
        let coordinator = 
    }
}
