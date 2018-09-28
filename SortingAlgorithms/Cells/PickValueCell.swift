//
//  PickValueCell.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 19.09.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class PickValueCell: UITableViewCell {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
