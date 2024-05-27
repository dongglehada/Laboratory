//
//  NetworkLayerVC.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/25/24.
//

import UIKit
import SnapKit
import RxSwift

final class NetworkLayerVC: UIViewController {
    
    let button = UIButton()
    
    let provider = ProviderImpl()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

private extension NetworkLayerVC {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.setTitle("request", for: .normal)
        button.backgroundColor = .red
        button.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalToSuperview()
        }
        
        button.addAction(UIAction(handler: { [weak self] _ in
            print("tapped")
            self?.fetchMovieList()
        }), for: .primaryActionTriggered)
        
    }
    
    func fetchMovieList() {
        let requestDTO = MovieListRequestDTO(query: "완득", language: "ko", year: "", api_key: Constants.accessKey)
        let endpoint = APIEndpoints.fetchSearchMovieList(with: requestDTO)
        
        provider.request(with: endpoint)
            .subscribe { response in
                print(response)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
    
}

struct Constants {
    static let accessKey = "44e4219e42a2f3b887055c843b1cb6c7"
}














