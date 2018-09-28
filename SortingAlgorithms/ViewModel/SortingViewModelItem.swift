//
//  SortingViewModelItem.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 25/09/2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import Foundation

enum SortingViewModelItemType {
    case animation
    case sortButton
    case speedSlider
    case performance
}

protocol SortingViewModelItem {
    var type: SortingViewModelItemType { get }
    var height: Float { get }
}
