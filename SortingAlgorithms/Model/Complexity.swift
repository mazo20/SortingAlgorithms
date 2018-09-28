//
//  Complexity.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 20.09.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import Foundation

class Complexity {
    enum Order {
        case sorted, almostSorted, random, reverse
    }
    
    var name: String?
    var value: String?
    var order: Order?
    
}
