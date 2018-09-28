//
//  SortingViewModelSliderItem.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 28/09/2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import Foundation

class SortingViewModelSliderItem: SortingViewModelItem {
    var type: SortingViewModelItemType {
        return .speedSlider
    }
    
    var height: Float {
        return 44
    }
    
    var valueChanged: (Float) -> ()
    
    init(valueChanged: @escaping (Float) -> ()) {
        self.valueChanged = valueChanged
    }
    
    
}
