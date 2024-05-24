//
//  PasteboardVC.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/24/24.
//

import UIKit
import RxCocoa
import SnapKit

final class PasteboardVC: UIViewController {
    
    private let pasteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        return button
    }()
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupAction()
    }
}

private extension PasteboardVC {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    func setupConstraints() {
        view.addSubview(pasteButton)
        view.addSubview(label)
        
        pasteButton.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupAction() {
        pasteButton.addAction(UIAction(handler: { [weak self] _ in
            print("tapped")
            print(UIPasteboard.general.string)
            self?.label.text = UIPasteboard.general.string
            //Optional("https://www.instagram.com/p/C7Oc3PaviS6/?igsh=MWt3cWhlb3RiZWxvcA==")
        }), for: .primaryActionTriggered)
    }
    
}
