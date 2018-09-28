//
//  ButtonCell.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 14.09.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    static let identifier = "ButtonCell"
    
    @IBOutlet var button: UIButton!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let item = item as? SortingViewModelButtonItem else { return }
        item.buttonPressed()
    }
    
    var item: SortingViewModelItem? {
        didSet {
            guard let item = item as? SortingViewModelButtonItem else { return }
            print(item.title)
            button.setTitle(item.title, for: .normal)
            button.layer.cornerRadius = 8
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}
