//
//  ViewModel.swift
//  RxCalculator
//
//  Created by 김규철 on 2023/03/24.
//

import Foundation

import RxSwift

import RxCocoa

final class ViewModel {
    
    // Input    
    let left = BehaviorRelay<Int>(value: 0)
    let right = BehaviorRelay<Int>(value: 0)

    // Output
    let result = BehaviorRelay<String>(value: "버튼을 눌러주세요.")
    
    let useCase: UseCase
    
    init(useCase: UseCase) {
        self.useCase = useCase
    }
    
    func calculate(operation: Operation) {
        let a = left.value
        let b = right.value
        
        switch operation {
        case .plus:
            result.accept(self.useCase.plus(left: a, right: b))
        case .subtraction:
            result.accept(self.useCase.subtract(left: a, right: b))
        case .multiplication:
            result.accept(self.useCase.multiply(left: a, right: b))
        case .divide:
            result.accept(self.useCase.divide(left: a, right: b))
        }
    }
}



