//
//  SortingAlgorithm.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 12.09.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import Foundation

struct SortingAlgorithm {
    static func insertionSort(items: [SortingItem], swapAnimation swap: (Int, Int) -> (), compareAnimation compare: (Int, Int) -> ()) -> [SortingItem] {
        var sortedItems = items
        let count = sortedItems.count
        for i in 1..<count {
            var j = i
            while j > 0 {
                compare(j, j-1)
                if sortedItems[j-1] > sortedItems[j] {
                    sortedItems.swapAt(j, j-1)
                    swap(j, j-1)
                } else {
                    break
                }
                j -= 1
            }
        }
        return sortedItems
    }
    
    static func bubbleSort(items: [SortingItem], swapAnimation swap: (Int, Int) -> (), compareAnimation compare: (Int, Int) -> ()) -> [SortingItem] {
        var sortedItems = items
        for i in 0..<sortedItems.count-1 {
            for j in 0..<sortedItems.count-1-i {
                compare(j, j+1)
                if sortedItems[j] > sortedItems[j+1] {
                    sortedItems.swapAt(j, j+1)
                    swap(j, j+1)
                }
            }
        }
        return sortedItems
    }
    
    static func heapsort(items: [SortingItem], swapAnimation: @escaping (Int, Int) -> (), compareAnimation compare: @escaping (Int, Int) -> ()) -> [SortingItem] {
        var sortedItems = items
        let count = sortedItems.count
        
        func shiftDown(start: Int, end: Int) {
            var root = start
            while root * 2 + 1 <= end {
                let child = root * 2 + 1
                var swap = root
                compare(swap, child)
                if sortedItems[swap] < sortedItems[child] {
                    swap = child
                }
                if child + 1 <= end {
                    compare(swap, child + 1)
                    if sortedItems[swap] < sortedItems[child + 1] {
                        swap = child + 1
                    }
                }
                guard swap != root else { return }
                sortedItems.swapAt(root, swap)
                swapAnimation(root, swap)
                root = swap
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
    
    static func quicksort(items: [SortingItem], swapAnimation swap: @escaping (Int, Int) -> (), compareAnimation compare: @escaping (Int, Int) -> ()) -> [SortingItem] {
        var sortedItems = items
        
        func quicksortMain(low: Int, high: Int){
            guard low < high else { return }
            let p = quicksortPartition(low: low, high: high)
            quicksortMain(low: low, high: p-1)
            quicksortMain(low: p+1, high: high)
        }
        
        func quicksortPartition(low: Int, high: Int) -> Int {
            let pivot = sortedItems[high]
            var i = low
            for j in low..<high {
                compare(j, high)
                if sortedItems[j] < pivot {
                    sortedItems.swapAt(i, j)
                    swap(i,j)
                    i += 1
                }
            }
            sortedItems.swapAt(i, high)
            swap(i, high)
            return i
        }
        
        quicksortMain(low: 0, high: items.count-1)
        return sortedItems
        
    }
    
    static func mergesort(items: [SortingItem], swapAnimation swap: @escaping (Int, Int) -> (), compareAnimation compare: (Int, Int) -> ()) -> [SortingItem] {
        var sortedItems = items
        
        func merge(leftStart: Int, leftEnd: Int, rightStart: Int, rightEnd: Int) {
            
            var merged = [SortingItem]()
            var left = leftStart
            var right = rightStart
            var index = leftStart
            
            while left <= leftEnd && right <= rightEnd {
                if items[left] < items[right] {
                    swap(left, index)
                    merged.append(items[left])
                    left += 1
                } else {
                    swap(right, index)
                    merged.append(items[right])
                    right += 1
                }
                index += 1
            }
            while left <= leftEnd {
                swap(left, index)
                merged.append(items[left])
                left += 1
                index += 1
            }
            while right <= rightEnd {
                swap(right, index)
                merged.append(items[right])
                right += 1
                index += 1
            }
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
}
