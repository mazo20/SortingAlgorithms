//
//  SwapAnimation.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 28.08.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

protocol Animatable {
    func run(withDuration duration: CFTimeInterval, completion: ((Bool) -> Void)?)
    func createAnimation(from: Any?, to: Any?, withDuration duration: CFTimeInterval) -> CABasicAnimation
}

class SwapAnimation: NSObject, CAAnimationDelegate, Animatable {
    let layer1: CAShapeLayer
    let layer2: CAShapeLayer
    let position1: CGPoint
    let position2: CGPoint
    var animation1: CABasicAnimation?
    var animation2: CABasicAnimation?
    
    private var finishedAnimations: Int = 0
    private var completion: ((Bool) -> Void)?
    
    init(layer1: CAShapeLayer, layer2: CAShapeLayer, position1: CGPoint, position2: CGPoint) {
        self.layer1 = layer1
        self.layer2 = layer2
        self.position1 = position1
        self.position2 = position2
    }
    
    func createAnimation(from: Any?, to: Any?, withDuration duration: CFTimeInterval) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.delegate = self
        return animation
    }
    
    func run(withDuration duration: CFTimeInterval, completion: ((Bool) -> Void)?) {
        layer1.position = position2
        layer2.position = position1
        self.animation1 = createAnimation(from: position1, to: position2, withDuration: duration)
        self.animation2 = createAnimation(from: position2, to: position1, withDuration: duration)
        layer1.add(animation1!, forKey: #keyPath(CALayer.position))
        layer2.add(animation2!, forKey: #keyPath(CALayer.position))
        
        self.completion = completion
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        finishedAnimations += 1
        
        if finishedAnimations == 2 {
            guard let completion = completion else { return }
            completion(true)
        }
    }
}
