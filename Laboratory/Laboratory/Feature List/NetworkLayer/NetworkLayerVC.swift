//
//  NetworkLayerVC.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/25/24.
//

import UIKit
import SnapKit

final class NetworkLayerVC: UIViewController {
    
    let button = UIButton()
    
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
//        let requestDTO = MovieListRequestDTO(query: "완득", language: "ko", page: 0, year: "", api_key: Constants.accessKey)
        let endpoint = APIEndpoints.fetchSearchMovieList(with: requestDTO)
        let provider = ProviderImpl()
        print("request start")
        provider.request(with: endpoint) { result in
            print("request end")
            switch result {
            case .success(let response):
                print(response.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

struct Constants {
    static let accessKey = "44e4219e42a2f3b887055c843b1cb6c7"
}














