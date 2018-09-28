//
//  ComplexityDetailCell.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 14.09.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class ComplexityDetailCell: UITableViewCell {
    
    @IBOutlet var averageCaseLabel: UILabel!
    @IBOutlet var worstCaseLabel: UILabel!
    @IBOutlet var bestCaseLabel: UILabel!
    @IBOutlet var averageCaseComplexityLabel: UILabel!
    @IBOutlet var worstCaseComplexityLabel: UILabel!
    @IBOutlet var bestCaseComplexityLabel: UILabel!
    
    static let identifier = "ComplexityDetailCell"
    
    var item: SortingViewModelItem? {
        didSet {
            guard let item = item as? SortingViewModelPerformanceItem else { return }
            averageCaseLabel.text = item.complexity
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
