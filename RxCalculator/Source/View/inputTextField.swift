//
//  inputTextField.swift
//  RxCalculator
//
//  Created by 김규철 on 2023/03/28.
//

import UIKit.UITextField

final class inputTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setUp()
    }
    
    convenience init(text: String) {
        self.init()
        placeholder = text
    }
    
    private func setUp() {
        heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func configUI() {
        backgroundColor = .systemGray6
        keyboardType = UIKeyboardType.numberPad
        borderStyle = .roundedRect
        clearButtonMode = .always
        layer.cornerRadius = 20
        clipsToBounds = true
        
        //조이님 잘 잘썼어요
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
