//
//  ViewController.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/24/24.
//

import UIKit
import RxCocoa
import SnapKit
import RxSwift
import SwiftUI

final class ViewController: UIViewController {
    
    struct VCData {
        var name: String
        var vc: UIViewController
    }
    
    private let controllers: BehaviorRelay<[VCData]> = .init(value: [
        .init(name: "PasteboardTest", vc: PasteboardVC()),
        .init(name: "NetworkLayerTest", vc: NetworkLayerVC()),
        .init(name: "SwiftUITest", vc: UIHostingController(rootView: SwiftUIFirstView())),
        .init(name: "Kakao Login", vc: KakaoViewController()),
        .init(name: "CustomPicker", vc: CustomPickerVC())
    ])
    
    private let disposeBag = DisposeBag()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupBind()
    }
}


private extension ViewController {
    
    func setupUI() {
        view.backgroundColor = .red
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func setupConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupBind() {
        
        tableView.rx.contentOffset.subscribe { point in
            print(point.element?.y)
        }
        .disposed(by: disposeBag)
        
        controllers.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { (row, element, cell) in
            cell.textLabel?.text = element.name
        }
        .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .withUnretained(self)
            .subscribe { (owner, index) in
                owner.navigationController?.pushViewController(owner.controllers.value[index.row].vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
