//
//  ViewController.swift
//  RxCalculator
//
//  Created by 김규철 on 2023/03/24.
//

import UIKit

import RxSwift

import RxCocoa

final class ViewController: UIViewController {
    
    private var viewModel: ViewModel!
    private let disposeBag = DisposeBag()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let leftHandSideTextField = inputTextField(text: "첫번째 숫자를 입력해주세요.")
    private let rightHandSideTextField = inputTextField(text: "두번째 숫자를 입력해주세요.")
    private let buttonView = ButtonView()
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setView()
        setUp()
        
        let useCase = UseCase()
        viewModel = ViewModel(useCase: useCase)
        
        bind()
        checkEmptyInput()
    }
    
    
    private func setView() {
        [leftHandSideTextField, rightHandSideTextField, valueLabel, buttonView].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView) }
    }
    
    private func setUp() {
        NSLayoutConstraint.activate([
            leftHandSideTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            leftHandSideTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 47),
            leftHandSideTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -47),
            
            rightHandSideTextField.topAnchor.constraint(equalTo: leftHandSideTextField.bottomAnchor, constant: 10),
            rightHandSideTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 47),
            rightHandSideTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -47),
            
            valueLabel.topAnchor.constraint(equalTo: rightHandSideTextField.bottomAnchor, constant: 20),
            valueLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            valueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            
            buttonView.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 28),
            buttonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 47),
            buttonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -47)
        ])
        
        leftHandSideTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        rightHandSideTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        valueLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    private func bind() {
        leftHandSideTextField.rx.text.orEmpty
            .map { Int($0) ?? 0 }
            .bind(to: viewModel.left)
            .disposed(by: disposeBag)
        
        rightHandSideTextField.rx.text.orEmpty
            .map { Int($0) ?? 0 }
            .bind(to: viewModel.right)
            .disposed(by: disposeBag)
        
        buttonView.plusButton.rx.tap
            .map { Operation.plus }
            .bind(onNext: { [weak self] op in
                self?.viewModel.calculate(operation: op)
            })
            .disposed(by: disposeBag)
        
        buttonView.subtractButton.rx.tap
            .map { Operation.subtraction }
            .bind(onNext: { [weak self] op in
                self?.viewModel.calculate(operation: op)
            })
            .disposed(by: disposeBag)
        
        buttonView.multiplyButton.rx.tap
            .map { Operation.multiplication }
            .bind(onNext: { [weak self] op in
                self?.viewModel.calculate(operation: op)
            })
            .disposed(by: disposeBag)
        
        buttonView.divideButton.rx.tap
            .map { Operation.divide }
            .bind(onNext: { [weak self] op in
                self?.viewModel.calculate(operation: op)
            })
            .disposed(by: disposeBag)
        
        //output
        viewModel.result
            .map {  String($0) }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
    
extension ViewController {
    private func checkEmptyInput() {
        Observable.merge(buttonView.plusButton.rx.tap.map{ $0 }, buttonView.multiplyButton.rx.tap.map{ $0 }, buttonView.subtractButton.rx.tap.map{ $0 }, buttonView.divideButton.rx.tap.map{ $0 })
            .subscribe(onNext: { [weak self] in
                let text1 = self?.leftHandSideTextField.text ?? ""
                let text2 = self?.rightHandSideTextField.text ?? ""
                if text1.isEmpty || text2.isEmpty {
                    self?.valueLabel.text = "모든 값을 입력하세요."
                }
            })
            .disposed(by: disposeBag)
        }
}


