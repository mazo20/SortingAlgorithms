//
//  SortedView.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 26.08.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class SortingViewCell: UITableViewCell {
    
    var sortingView: SortingView?
    
    fileprivate let leftEdgeInset: CGFloat = 20
    
    static let identifier = "SortingViewCell"
    
    var item: SortingViewModelItem? {
        didSet {
            guard let item = item as? SortingViewModelAnimationItem else { return }
            
            
            item.isAnimating.valueChanged = { [weak self] (isAnimating) in
                if isAnimating {
                    self?.sortingView?.sort(with: item.sortingType)
                }
            }
            item.animationSpeed.valueChanged = { [weak self] (animationSpeed) in
                guard animationSpeed > 0 && animationSpeed <= 1 else { return }
                self?.sortingView?.animationSpeed = Double(animationSpeed)
            }
            if sortingView == nil || !self.subviews.contains(sortingView!) {
                sortingView = SortingView(frame: CGRect(x: leftEdgeInset, y: 0, width: bounds.size.width-2*leftEdgeInset, height: bounds.size.height))
                sortingView!.draw(array: Array(1...item.numberOfValues))
                sortingView!.animationSpeed = 100
                addSubview(sortingView!)
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}
