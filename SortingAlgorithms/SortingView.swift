//
//  SortingView.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 27.08.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class SortingView: UIView {
    
    var items: [SortingItem]?
    var itemLayers: [CAShapeLayer]?
    
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
        let count = array.count
        let width = frame.width / CGFloat(count)
        let max = array.max()!
        
        let colors = colorsForValues(array: array)
        
        var items = [SortingItem]()
        
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
            layer.fillColor = item.color.cgColor
            layer.strokeColor = item.color.cgColor
            layer.path = path.cgPath
            layer.position = CGPoint(x: CGFloat(i) * width, y: frame.maxY)
            layers.append(layer)
            self.layer.addSublayer(layer)
        }
        itemLayers = layers
    }
    
    func sort() {
        var animations = [SwapAnimation]()
        var totalDuration: Double = 0
        guard var items = items else { return }
        for i in 0..<items.count-1 {
            for j in 0..<items.count-1-i {
                if items[j].value > items[j+1].value {
                    items.swapAt(j, j+1)
                    animations.append(animateSwap(layer1: itemLayers![j], layer2: itemLayers![j+1], withDuration: 3.0, beginTime: totalDuration))
                    itemLayers?.swapAt(j, j+1)
                    totalDuration += 1
                }
            }
        }
        self.items = items
        
        //var totalDuration: Double = 0
        for swap in animations {
            print(totalDuration)
            swap.animation1.beginTime = totalDuration
            swap.animation2.beginTime = totalDuration
            swap.layer1.position = swap.position2
            print(swap.position2)
            print(swap.position1)
            swap.layer2.position = swap.position1
            //swap.layer1.add(swap.animation1, forKey: #keyPath(CALayer.position))
            //swap.layer2.add(swap.animation2, forKey: #keyPath(CALayer.position))
            
            //totalDuration += 2
        }
        
        
    }
    
    func animateSwap(layer1: CAShapeLayer, layer2: CAShapeLayer, withDuration duration: Double, beginTime: Double) -> SwapAnimation {
        let position1 = layer1.position
        let position2 = layer2.position
        
        let animation1 = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animation1.beginTime = beginTime + CACurrentMediaTime()
        animation1.fromValue = position1
        animation1.toValue = position2
        animation1.duration = duration
        animation1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        layer1.position = position2
        layer1.add(animation1, forKey: #keyPath(CALayer.position))
        
        let animation2 = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animation2.beginTime = beginTime + CACurrentMediaTime()
        animation2.fromValue = position2
        animation2.toValue = position1
        animation2.duration = duration
        animation2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        print(animation2.duration)
        
        layer2.position = position1
        layer2.add(animation2, forKey: #keyPath(CALayer.position))
        
        return SwapAnimation(layer1: layer1, layer2: layer2, position1: position1, position2: position2, animation1: animation1, animation2: animation2)
    }
    
    private func colorsForValues(array: [Int]) -> [UIColor] {
        let count = array.count
        var colors = [UIColor]()
        let colorLength = 1530 / (count - 1)
        print(colorLength)
        
        for i in 0..<count {
            colors.append(colorFor(length: colorLength*i))
            print(colorLength*i)
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
        case 256...510:
            green = 255
            red = 255 - length%256
        case 511...765:
            red = 0
            green = 255
            blue = length%256
        case 766...1020:
            red = 0
            green = 255-length%256
            blue = 255
        case 1021...1275:
            red = length%256
            green = 0
            blue = 255
        default:
            red = 255
            green = 0
            blue = 255-length%256
        }
        return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1)
    }
    
    
}


