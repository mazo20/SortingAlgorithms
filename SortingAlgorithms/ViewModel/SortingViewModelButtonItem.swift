//
//  SortingViewModelButtonItem.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 25/09/2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import Foundation

class SortingViewModelButtonItem: SortingViewModelItem {
    
    var type: SortingViewModelItemType {
        return .sortButton
    }
    
    var height: Float {
        return 44
    }
    
    var title: String
    
    init(title: String, buttonPressed: @escaping () -> ()) {
        self.title = title
        self.buttonPressed = buttonPressed
    }
    
    var buttonPressed: () -> ()
    
    func buttonnPressed() {
        //flawlessapp.io/blog/advanded-mvvm-tableview-tutorial
    }
}
