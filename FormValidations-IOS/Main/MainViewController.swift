//
//  ViewController.swift
//  FormValidations-IOS
//
//  Created by Yair Carreno on 2/24/19.
//  Copyright © 2019 Yair Carreno. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var fullnameWarning: UILabel!
    @IBOutlet weak var passwordWarning: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    let disposeBag = DisposeBag()
    let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // username group field dependencies
        _ = ChangeManager
            .Builder()
            .setSource(controlProperty: fullname.rx.text.orEmpty, viewModelProperty: viewModel.user)
            .setValidationFunction(validationFunction: viewModel.isUserValid)
            .setObservers(observerList: [fullnameWarning.rx.isHidden, password.rx.isEnabled])
            .build()
        
        // password group field dependencies
        _ = ChangeManager
            .Builder()
            .setSource(controlProperty: password.rx.text.orEmpty, viewModelProperty: viewModel.pass)
            .setValidationFunction(validationFunction: viewModel.isPassValid)
            .setObservers(observerList: [passwordWarning.rx.isHidden])
            .build()
        
        // group button dependencies
        _ = ChangeManager
            .Builder()
            .setValidationFunction(validationFunction: viewModel.isValid)
            .setObservers(observerList: [submitButton.rx.isEnabled])
            .build()
        
        submitButton.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.doAction() })
            .disposed(by: disposeBag)
    }
    
    func doAction() {
        print("Action executed!")
    }
}

