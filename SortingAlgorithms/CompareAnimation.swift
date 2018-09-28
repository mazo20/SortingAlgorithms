//
//  CompareAnimation.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 06.09.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class CompareAnimation: NSObject, CAAnimationDelegate, Animatable {
    
    let layer1: CAShapeLayer
    let layer2: CAShapeLayer
    var animation1: CABasicAnimation?
    var animation2: CABasicAnimation?
    var completion: ((Bool) -> Void)?
    private var finishedAnimations: Int = 0
    
    init(layer1: CAShapeLayer, layer2: CAShapeLayer) {
        self.layer1 = layer1
        self.layer2 = layer2
    }
    
    func createAnimation(from: Any?, to: Any?, withDuration duration: CFTimeInterval) -> CABasicAnimation {
        
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.fillColor))
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.delegate = self
        return animation
    }
    
    func run(withDuration duration: CFTimeInterval, completion: ((Bool) -> Void)?) {
        self.animation1 = createAnimation(from: layer1.fillColor, to: UIColor.black.cgColor, withDuration: duration)
        self.animation2 = createAnimation(from: layer2.fillColor, to: UIColor.black.cgColor, withDuration: duration)
        layer1.add(animation1!, forKey: nil)
        layer2.add(animation2!, forKey: nil)
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
