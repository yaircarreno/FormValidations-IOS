//
//  ChangeManager.swift
//  FormValidations-IOS
//
//  Created by Yair Carreno on 3/8/19.
//  Copyright © 2019 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ChangeManager {
    
    private let controlProperty: ControlProperty<String>?
    private let viewModelProperty: BehaviorRelay<String>?
    private let validationFunction: Observable<Bool>?
    
    init(builder: Builder){
        controlProperty = builder.controlProperty
        viewModelProperty = builder.viewModelProperty
        validationFunction = builder.validationFunction
    }
    
    class Builder {
        
        private(set) var controlProperty: ControlProperty<String>?
        private(set) var viewModelProperty: BehaviorRelay<String>?
        private(set) var validationFunction: Observable<Bool>?
        
        func setSource(controlProperty: ControlProperty<String>, viewModelProperty: BehaviorRelay<String>) -> Builder {
            self.controlProperty = controlProperty
            self.viewModelProperty = viewModelProperty
            self.validationFunction = Observable.empty()
            _ = self.controlProperty!.bind(to: self.viewModelProperty!)
            return self
        }
        
        func setValidationFunction(validationFunction: Observable<Bool>) -> Builder {
            self.validationFunction = validationFunction
            return self
        }
        
        func setObservers(observerList: [Binder<Bool>]) -> Builder {
            for observer in observerList {
                _ = self.validationFunction!.bind(to: observer)
            }
            return self
        }
        
        func build() -> ChangeManager {
            return ChangeManager(builder: self)
        }
    }
}
