//
//  RegistrationViewModel.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/03/11.
//

import UIKit

class RegistrationViewModel {
//    var image: UIImage? {
//        didSet {
//            imageObserver?(image)
//        }
//    }
//    var imageObserver: ((UIImage?) -> ())?
    var bindableImage = Bindable<UIImage>()
    
    var fullName: String? { didSet { checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
//        isFormValidObserver?(isFormValid)
        bindableIsFormValid.value = isFormValid
    }
    
    // Reactive programming
//    var isFormValidObserver: ((Bool) -> ())?
    var bindableIsFormValid = Bindable<Bool>()
}
