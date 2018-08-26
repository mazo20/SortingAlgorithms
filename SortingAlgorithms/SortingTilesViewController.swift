//
//  SortingTilesCollectionView.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 26.08.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import Foundation
import UIKit

class SortingTilesCollectionViewController: UICollectionViewController {
    
    fileprivate let reuseIdentidier = "SortingAlgorithmCell"
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
    
    let sortingTypes = ["Bubble sort", "Insertion sort", "Quicksort", "Heap sort", "Merge sort"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SortingTypeCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: reuseIdentidier)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentidier, for: indexPath) as! SortingTypeCell
        
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.backgroundColor = .white
        
        cell.titleLabel.text = sortingTypes[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowSorting", sender: self)
    }
}

extension SortingTilesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (2 + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
}
