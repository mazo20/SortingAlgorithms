//
//  SortedView.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 26.08.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class SortingViewCell: UITableViewCell {
    
    @IBOutlet var sortingView: SortingView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
