//
//  SortingView.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 27.08.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class SortingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func draw(array: [Int]) {
        let count = array.count
        let width = frame.width / CGFloat(count)
        let max = array.max()!
        print(frame.width)
        print(width)
        
        for (i, number) in array.enumerated() {
            let height = CGFloat(number)/CGFloat(max) * width
            let rect = CGRect(x: 0 + CGFloat(i) * width, y: 0, width: width, height: height)
            let path = UIBezierPath(rect: rect)
            
            let layer = CAShapeLayer()
            layer.fillColor = UIColor.red.cgColor
            layer.path = path.cgPath
            self.layer.addSublayer(layer)
            print(path)
        }
    }
    
    
}


