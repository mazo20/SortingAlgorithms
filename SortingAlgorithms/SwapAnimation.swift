//
//  SwapAnimation.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 28.08.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class SwapAnimation {
    let layer1: CAShapeLayer
    let layer2: CAShapeLayer
    let position1: CGPoint
    let position2: CGPoint
    let animation1: CABasicAnimation
    let animation2: CABasicAnimation
    
    init(layer1: CAShapeLayer, layer2: CAShapeLayer, position1: CGPoint, position2: CGPoint, animation1: CABasicAnimation, animation2: CABasicAnimation) {
        self.layer1 = layer1
        self.layer2 = layer2
        self.position1 = position1
        self.position2 = position2
        self.animation1 = animation1
        self.animation2 = animation2
    }
}
