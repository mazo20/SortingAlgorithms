//
//  DescriptionCell.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 14.09.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    @IBOutlet var textView: UITextView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
