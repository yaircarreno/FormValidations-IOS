//
//  MainViewModel.swift
//  FormValidations-IOS
//
//  Created by Yair Carreno on 2/24/19.
//  Copyright © 2019 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    
    var user = BehaviorRelay<String>(value: "")
    var pass = BehaviorRelay<String>(value: "")
    
    var isUserValid: Observable<Bool> {
        return user.asObservable().map {$0.count > 5 }
    }
    
    var isPassValid: Observable<Bool> {
        return pass.asObservable().map {$0.count > 5 }
    }
    
    var isValid : Observable<Bool>{
        return Observable.combineLatest( isUserValid, isPassValid){ $0 && $1 }
    }
}
