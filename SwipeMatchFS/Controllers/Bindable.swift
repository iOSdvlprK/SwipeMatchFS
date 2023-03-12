//
//  Bindable.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/03/12.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) ->()) {
        self.observer = observer
    }
}
