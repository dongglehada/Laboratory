//
//  CustomPickerVC.swift
//  Laboratory
//
//  Created by SeoJunYoung on 6/22/24.
//

import UIKit
import SnapKit

class CustomPickerVC: UIViewController {
    
    let pickerView: UIPickerView = {
        let view = UIPickerView()
        return view
    }()
    
    let nums = (0...100).map { nums in
        String(nums) + "세"
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        pickerView.delegate = self
        pickerView.dataSource = self
//        pickerView.
        view.addSubview(pickerView)
        
        pickerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
            make.center.equalToSuperview()
        }
    }
    
    override func viewWillLayoutSubviews() {
        pickerView.subviews[1].backgroundColor = .systemBlue
        pickerView.subviews[1].alpha = 0.1
    }
}

extension CustomPickerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nums.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return nums[row]
//    }
    
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 10
//    }
    
//    picker
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        let label = UILabel()
        label.text = nums[row]
        label.textAlignment = .center
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        if pickerView.selectedRow(inComponent: component) == row {
            print(row)
            label.font = .boldSystemFont(ofSize: 20)
        }
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print(pickerView.selectedRow(inComponent: component))
        pickerView.reloadAllComponents()
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        <#code#>
//    }
}
