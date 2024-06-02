//
//  BViewController.swift
//  Laboratory
//
//  Created by SeoJunYoung on 6/2/24.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol BViewNavigation: AnyObject {
    func pushToDViewController()
}

class BViewController: UIViewController {
    
    weak var delegate: BViewNavigation?
    
    var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalToSuperview()
        }
        
        button.rx.tap.subscribe { [weak self] _ in
            print("Tapped")
            self?.delegate?.pushToDViewController()
        }
        .disposed(by: disposeBag)
    }
    
    deinit {
        print(self, "deinit")
    }
    
}

class BViewCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print(self, "deinit")
    }
    
    func start() {
        print(self, "start")
        let bVC = BViewController()
        bVC.delegate = self
        navigationController.viewControllers = [bVC]
    }
    
}

extension BViewCoordinator: BViewNavigation {
    func pushToDViewController() {
        print(#function)
        let dVC = DViewController()
        navigationController.pushViewController(dVC, animated: true)
    }
}
