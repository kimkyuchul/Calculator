//
//  UseCase.swift
//  RxCalculator
//
//  Created by 김규철 on 2023/03/24.
//

import Foundation

import RxSwift


final class UseCase {
    
    func plus(left: Int, right: Int) -> String {
        let result = left + right
        return "\(left) + \(right) = \(result)"
    }
    
    func subtract(left: Int, right: Int) -> String {
        let result = left - right
        return "\(left) - \(right) = \(result)"
    }
    
    func multiply(left: Int, right: Int) -> String {
        let result = left * right
        return "\(left) * \(right) = \(result)"
    }
    
    func divide(left: Int, right: Int) -> String {
        if right == 0 {
            return "0으로 나눌 수 없습니다."
        } else {
            let result = left / right
            return "\(left) / \(right) = \(result)"
        }
    }
}
