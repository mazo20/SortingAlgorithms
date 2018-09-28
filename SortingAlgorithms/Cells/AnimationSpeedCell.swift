//
//  AnimationSpeedCell.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 06.09.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class AnimationSpeedCell: UITableViewCell {
    
    static let identifier = "AnimationSpeedCell"
    
    @IBOutlet var speedSlider: UISlider!
    
    @IBAction func valueChanged(_ sender: UISlider) {
        
        guard let item = item as? SortingViewModelSliderItem else { return }
        item.valueChanged(speedSlider.value)
    }
    
    var item: SortingViewModelItem? {
        didSet {
            //guard let item = item as? SortingViewModelSliderItem else { return }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
