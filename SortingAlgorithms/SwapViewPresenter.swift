//
//  SwapViewPresenter.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 06.09.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class SwapViewPresenter {
    
    var items: [SortingItem]?
    var itemLayers: [CAShapeLayer]?
    var itemLayerPositions: [CGPoint]?
    var swapAnimations = [SwapAnimation]()
    
    
    fileprivate var finishedAnimations: Int = 0
    fileprivate var currentAnimation: Int = 0
    
    
    func sort(with sorting: SortingType) {
        swapAnimations.removeAll()
        switch sorting {
        case .bubble:
            items = bubbleSort(items: items!, swapAnimation: swapAnimationForIndex(i:j:))
        case .insertion:
            items = inserionSort(items: items!, swapAnimation: swapAnimationForIndex(i:j:))
        case .quicksort:
            items = quicksort(items: items!, swapAnimation: swapAnimationForIndex(i:j:))
        case .heapsort:
            items = heapsort(items: items!, swapAnimation: swapAnimationForIndex(i:j:))
        case .merge:
            items = mergesort(items: items!, swapAnimation: swapAnimationForIndex(i:j:))
        default:
            items = quicksort(items: items!, swapAnimation: swapAnimationForIndex(i:j:))
        }
        
        guard !swapAnimations.isEmpty else { return }
        fireAnimation(swap: swapAnimations[0])
    }
    
    func inserionSort(items: [SortingItem], swapAnimation: (Int, Int) -> ()) -> [SortingItem] {
        var sortedItems = items
        let count = sortedItems.count
        for i in 1..<count {
            var j = i
            while j > 0 && sortedItems[j-1].value > sortedItems[j].value {
                sortedItems.swapAt(j, j-1)
                swapAnimation(j, j-1)
                j -= 1
            }
        }
        return sortedItems
    }
    
    func bubbleSort(items: [SortingItem], swapAnimation: (Int, Int) -> ()) -> [SortingItem] {
        var sortedItems = items
        for i in 0..<sortedItems.count-1 {
            for j in 0..<sortedItems.count-1-i {
                if sortedItems[j].value > sortedItems[j+1].value {
                    sortedItems.swapAt(j, j+1)
                    swapAnimation(j, j+1)
                }
            }
        }
        return sortedItems
    }
    
    func heapsort(items: [SortingItem], swapAnimation: @escaping (Int, Int) -> ()) -> [SortingItem] {
        var sortedItems = items
        let count = sortedItems.count
        
        func shiftDown(start: Int, end: Int) {
            var root = start
            while root * 2 + 1 <= end {
                let child = root * 2 + 1
                var swap = root
                if sortedItems[swap].value < sortedItems[child].value {
                    swap = child
                }
                if child + 1 <= end && sortedItems[swap].value < sortedItems[child + 1].value {
                    swap = child + 1
                }
                if swap == root {
                    return
                } else {
                    sortedItems.swapAt(root, swap)
                    swapAnimation(root, swap)
                    root = swap
                }
            }
        }
        
        func heapify(count: Int) {
            var start = (count - 2) / 2
            while start >= 0 {
                shiftDown(start: start, end: count - 1)
                start -= 1
            }
        }
        
        heapify(count: count)
        var end = count - 1
        
        while end > 0 {
            sortedItems.swapAt(0, end)
            swapAnimation(0, end)
            end -= 1
            
            shiftDown(start: 0, end: end)
        }
        
        return sortedItems
    }
    
    
    func quicksort(items: [SortingItem], swapAnimation: @escaping (Int, Int) -> ()) -> [SortingItem] {
        var sortedItems = items
        
        func quicksortMain(low: Int, high: Int){
            guard low < high else { return }
            let p = quicksortPartition(low: low, high: high)
            quicksortMain(low: low, high: p-1)
            quicksortMain(low: p+1, high: high)
        }
        
        func quicksortPartition(low: Int, high: Int) -> Int {
            let pivot = sortedItems[high].value
            var i = low
            for j in low..<high {
                if sortedItems[j].value < pivot {
                    sortedItems.swapAt(i, j)
                    swapAnimation(i,j)
                    i += 1
                }
            }
            sortedItems.swapAt(i, high)
            swapAnimation(i, high)
            return i
        }
        
        quicksortMain(low: 0, high: items.count-1)
        return sortedItems
        
    }
    
    func mergesort(items: [SortingItem], swapAnimation: @escaping (Int, Int) -> ()) -> [SortingItem] {
        var sortedItems = items
        
        func merge(leftStart: Int, leftEnd: Int, rightStart: Int, rightEnd: Int) {
            
            var merged = [SortingItem]()
            var left = leftStart
            var right = rightStart
            var index = leftStart
            
            while left <= leftEnd && right <= rightEnd {
                if items[left].value < items[right].value {
                    swapAnimation(left, index)
                    merged.append(items[left])
                    left += 1
                } else {
                    swapAnimation(right, index)
                    merged.append(items[right])
                    right += 1
                }
                index += 1
            }
            while left <= leftEnd {
                swapAnimation(left, index)
                merged.append(items[left])
                left += 1
                index += 1
            }
            while right <= rightEnd {
                swapAnimation(right, index)
                merged.append(items[right])
                right += 1
                index += 1
            }
            dump(merged)
            for (i, item) in merged.enumerated() {
                sortedItems[leftStart+i] = item
            }
            
        }
        
        func mergeSort(leftStart: Int, rightEnd: Int) {
            if (rightEnd-leftStart) > 1 {
                mergeSort(leftStart: leftStart, rightEnd: leftStart + (rightEnd-leftStart)/2)
                mergeSort(leftStart: leftStart + (rightEnd-leftStart)/2 + 1 , rightEnd: rightEnd)
            }
            print("\(leftStart) \(leftStart + (rightEnd-leftStart)/2 ) \(leftStart + (rightEnd-leftStart)/2 + 1) \(rightEnd)")
            merge(leftStart: leftStart, leftEnd: leftStart + (rightEnd-leftStart)/2   , rightStart: leftStart + (rightEnd-leftStart)/2 + 1 , rightEnd: rightEnd)
        }
        mergeSort(leftStart: 0, rightEnd: items.count - 1)
        
        dump(sortedItems)
        return sortedItems
    }
    
    func swapAnimationForIndex(i: Int, j: Int) {
        guard i != j else { return }
        let layer1 = itemLayers![i]
        let layer2 = itemLayers![j]
        let position1 = itemLayerPositions![i]
        let position2 = itemLayerPositions![j]
        
        let swapAnimation = SwapAnimation(layer1: layer1, layer2: layer2, position1: position1, position2: position2)
        swapAnimations.append(swapAnimation)
        itemLayers?.swapAt(i, j)
    }
    
    func fireAnimation(swap: SwapAnimation) {
        swap.run(withDuration: 0.01, completion: { [weak self] finished in
            if self == nil { return }
            self!.currentAnimation += 1
            guard self!.currentAnimation < self!.swapAnimations.count else { return }
            print("Fire animation \(self!.currentAnimation)")
            self!.fireAnimation(swap: self!.swapAnimations[self!.currentAnimation])
        })
        
        
    }
    
    private func colorsForValues(array: [Int]) -> [UIColor] {
        let count = array.count
        var colors = [UIColor]()
        let colorLength = 1530 / (count - 1)
        
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
            red = 255 - length%256
        case 512...767:
            red = 0
            green = 255
            blue = length%256
        case 768...1023:
            red = 0
            green = 255-length%256
            blue = 255
        case 1024...1279:
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
