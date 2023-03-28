//
//  ButtonView.swift
//  RxCalculator
//
//  Created by 김규철 on 2023/03/24.
//

import UIKit.UIStackView

final class ButtonView: UIStackView {
    
    let plusButton = CalculatorButton(color: .systemTeal, title: "더하기")
    let subtractButton = CalculatorButton(color: .systemTeal, title: "빼기")
    let multiplyButton = CalculatorButton(color: .systemTeal, title: "곱하기")
    let divideButton = CalculatorButton(color: .systemTeal, title: "나누기")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        alignment = .fill
        spacing = 10
        
        setUp()
    }
    
    private func setUp() {
        [plusButton, subtractButton, multiplyButton, divideButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(subView)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
