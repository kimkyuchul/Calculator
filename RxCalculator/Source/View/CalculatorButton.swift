//
//  CalculatorButton.swift
//  RxCalculator
//
//  Created by 김규철 on 2023/03/24.
//

import UIKit.UIButton

final class CalculatorButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setUp()
    }
    
    convenience init(color: UIColor, title: String) {
        self.init()
        backgroundColor = color
        setTitle(title, for: .normal)
    }
    
    private func setUp() {
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configUI() {
        layer.masksToBounds = true
        layer.cornerRadius = 15
        titleLabel?.font = .boldSystemFont(ofSize: 12)
        setTitleColor(.white, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
