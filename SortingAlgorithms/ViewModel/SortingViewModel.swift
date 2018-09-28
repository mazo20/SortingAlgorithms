//
//  SortingViewModel.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 25/09/2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class SortingViewModel: NSObject {
    var items = Observable<[SortingViewModelItem]>([])
    var sortingType: SortingType?
    
    override init() {
        super.init()
    }
    
    convenience init(withSorting sorting: SortingType) {
        self.init()
        sortingType = sorting
        let animationItem = SortingViewModelAnimationItem(type: sortingType!, numberOfValues: 100, animationSpeed: 0.5)
        items.value.append(animationItem)
        
        let buttonPressed = { [weak self] in
            animationItem.isAnimating.value = true
            self?.items.value.remove(at: 1)
            let sliderItem = SortingViewModelSliderItem(valueChanged: { (value) in
                animationItem.animationSpeed.value = value
            })
            self?.items.value.insert(sliderItem, at: 1)
        }
        let sortButtonItem = SortingViewModelButtonItem(title: "Sort", buttonPressed: buttonPressed)
        items.value.append(sortButtonItem)
        
        let performanceItem = SortingViewModelPerformanceItem(complexity: "ababa")
        items.value.append(performanceItem)
    }
}

extension SortingViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items.value[indexPath.row]
        
        switch item.type {
        case .animation:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SortingViewCell.identifier, for: indexPath) as? SortingViewCell {
                cell.item = item
                return cell
            }
        case .performance:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ComplexityDetailCell.identifier, for: indexPath) as? ComplexityDetailCell {
                cell.item = item
                return cell
            }
        case .speedSlider:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AnimationSpeedCell.identifier, for: indexPath) as? AnimationSpeedCell {
                cell.item = item
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell {
                cell.item = item
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items.value[indexPath.row]
        
        return CGFloat(item.height)
    }
    
    
}
