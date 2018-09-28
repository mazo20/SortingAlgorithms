//
//  SortingItem.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 27.08.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

struct SortingItem: Comparable {
    
    var value: Int
    var color: UIColor
    
    init(value: Int, color: UIColor) {
        self.value = value
        self.color = color
    }
    
    static func < (lhs: SortingItem, rhs: SortingItem) -> Bool {
        return lhs.value < rhs.value
    }
    
}
