//
//  AViewController.swift
//  Laboratory
//
//  Created by SeoJunYoung on 6/2/24.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol AViewNavigation: AnyObject {
    func pushToCViewController()
}

class AViewController: UIViewController {

    weak var delegate: AViewNavigation?
    
    var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalToSuperview()
        }
        
        button.rx.tap.subscribe { [weak self] _ in
            print("Tapped")
            self?.delegate?.pushToCViewController()
        }
        .disposed(by: disposeBag)
    }
    
    deinit {
        print(self, "deinit")
    }
    
}

class AViewCoordinator: Coordinator {
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
        let aVC = AViewController()
        aVC.delegate = self
        navigationController.viewControllers = [aVC]
    }
    
}

extension AViewCoordinator: AViewNavigation {
    func pushToCViewController() {
        print(#function)
        let cVC = CViewController()
        navigationController.pushViewController(cVC, animated: true)
    }
}
