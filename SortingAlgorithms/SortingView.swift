//
//  SortingView.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 27.08.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

enum SortingType: Int {
    case bubble, insertion, quicksort, heapsort, merge
}

class SortingView: UIView {
    
    var items: [SortingItem]?
    var itemLayers: [CAShapeLayer]?
    var itemLayerPositions: [CGPoint]?
    var animations = [Animatable]()
    var animationSpeed: Double = 50
    
    var animationDuration: Double {
        return 1.01 - animationSpeed
    }
    
    fileprivate var finishedAnimations: Int = 0
    fileprivate var currentAnimation: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = .clear
    }
    
    func draw(array: [Int]) {
        guard !array.isEmpty else { return }
        guard itemLayers == nil else { return }
        let count = array.count
        let width = frame.width / CGFloat(count)
        let max = array.max()!
        
        let colors = colorsForValues(array: array)
        
        var items = [SortingItem]()
        var positions = [CGPoint]()
        
        for i in 0..<count {
            let item = SortingItem(value: array[i], color: colors[i])
            items.append(item)
        }
        
        items.shuffle()
        self.items = items
        
        var layers = [CAShapeLayer]()
        for (i, item) in items.enumerated() {
            let height = CGFloat(item.value)/CGFloat(max) * frame.height
            let rect = CGRect(x: 0, y: 0, width: width, height: -height)
            let path = UIBezierPath(rect: rect)
            
            let layer = CAShapeLayer()
            //layer.frame = rect
            layer.fillColor = item.color.cgColor
            layer.backgroundColor = item.color.cgColor
            layer.strokeColor = item.color.cgColor
            layer.path = path.cgPath
            layer.position = CGPoint(x: CGFloat(i) * width, y: frame.maxY)
            positions.append(layer.position)
            layers.append(layer)
            self.layer.addSublayer(layer)
        }
        itemLayers = layers
        itemLayerPositions = positions
    }
    
    func sort(with sorting: SortingType) {
        animations.removeAll()
        guard let items = items else { return }
        switch sorting {
        case .bubble:
            self.items = SortingAlgorithm.bubbleSort(items: items, swapAnimation: swapAnimationForIndex(i:j:), compareAnimation: compareAnimationFor(i:j:))
        case .insertion:
            self.items = SortingAlgorithm.insertionSort(items: items, swapAnimation: swapAnimationForIndex(i:j:), compareAnimation: compareAnimationFor(i:j:))
        case .quicksort:
            self.items = SortingAlgorithm.quicksort(items: items, swapAnimation: swapAnimationForIndex(i:j:), compareAnimation: compareAnimationFor(i:j:))
        case .heapsort:
            self.items = SortingAlgorithm.heapsort(items: items, swapAnimation: swapAnimationForIndex(i:j:), compareAnimation: compareAnimationFor(i:j:))
        case .merge:
            self.items = SortingAlgorithm.mergesort(items: items, swapAnimation: swapAnimationForIndex(i:j:), compareAnimation: compareAnimationFor(i:j:))
        }
        
        guard let animation = animations.first else { return }
        fire(animation: animation, withDuration: animationDuration)
        
    }
    
    private func swapAnimationForIndex(i: Int, j: Int) {
        guard i != j else { return }
        let layer1 = itemLayers![i]
        let layer2 = itemLayers![j]
        let position1 = itemLayerPositions![i]
        let position2 = itemLayerPositions![j]
        
        let swapAnimation = SwapAnimation(layer1: layer1, layer2: layer2, position1: position1, position2: position2)
        animations.append(swapAnimation)
        itemLayers?.swapAt(i, j)
    }
    
    private func compareAnimationFor(i: Int, j: Int) {
        guard i != j else { return }
        let layer1 = itemLayers![i]
        let layer2 = itemLayers![j]
        let compareAnimation = CompareAnimation(layer1: layer1, layer2: layer2)
        animations.append(compareAnimation)
    }
    
    func fire(animation: Animatable, withDuration duration: CFTimeInterval) {
        animation.run(withDuration: duration, completion: { [weak self] finished in
            if self == nil { return }
            self!.currentAnimation += 1
            guard self!.currentAnimation < self!.animations.count else { return }
            self!.fire(animation: self!.animations[self!.currentAnimation], withDuration: self!.animationDuration)
        })
    }
    
    private func colorsForValues(array: [Int]) -> [UIColor] {
        let count = array.count
        var colors = [UIColor]()
        let colorLength = 1530 / count
        
        for i in 0..<count {
            colors.append(colorFor(length: colorLength*i))
        }
        return colors
    }
    
    private func colorFor(length: Int) -> UIColor {
        var red = 255
        var green = 0
        var blue = 0
        switch length {
        case 0...255:
            green = length
        case 256...511:
            green = 255
            red = 255 - length % 256
        case 512...767:
            red = 0
            green = 255
            blue = length % 256
        case 768...1023:
            red = 0
            green = 255 - length % 256
            blue = 255
        case 1024...1279:
            red = length % 256
            green = 0
            blue = 255
        default:
            red = 255
            green = 0
            blue = 255 - length % 256
        }
        return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1)
    }
}
