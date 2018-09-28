//
//  SortingViewModelPerformanceItem.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 26/09/2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class SortingViewModelPerformanceItem: SortingViewModelItem {
    var type: SortingViewModelItemType {
        return .performance
    }
    
    var height: Float {
        return 150
    }
    
    var complexity: String
    
    init(complexity: String) {
        self.complexity = complexity
    }
    
}
