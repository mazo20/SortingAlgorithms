//
//  SortingViewModelAnimationItem.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 25/09/2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import Foundation

class SortingViewModelAnimationItem: SortingViewModelItem {
    var type: SortingViewModelItemType {
        return .animation
    }
    
    var height: Float {
        return 200
    }
    
    var isAnimating: Observable<Bool>
    var numberOfValues: Int
    var animationSpeed: Observable<Float>
    var sortingType: SortingType
    
    init(type: SortingType, numberOfValues: Int, animationSpeed: Float) {
        self.numberOfValues = numberOfValues
        self.isAnimating = Observable(false)
        self.animationSpeed = Observable(animationSpeed)
        self.sortingType = type
        
    }
    
}
