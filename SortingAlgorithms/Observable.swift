//
//  Observable.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 26/09/2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }
    var valueChanged: ((T) -> Void)?
    
    init(_ t: T) {
        value = t
    }
}
