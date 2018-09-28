//
//  SortingViewController.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 26.08.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class SortingTableViewController: UITableViewController {
    
    var sorting: SortingType!
    let sortingTypes = ["Bubble sort", "Insertion sort", "Quicksort", "Heap sort", "Merge sort"]
    
    var sortingViewModel: SortingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortingViewModel = SortingViewModel(withSorting: sorting)
        sortingViewModel.items.valueChanged = { [weak self] _ in
            self?.tableView.reloadData()
        }
        tableView.dataSource = sortingViewModel
        tableView.delegate = sortingViewModel
        
        tableView.register(UINib(nibName: SortingViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: SortingViewCell.identifier)
        tableView.register(UINib(nibName: AnimationSpeedCell.identifier, bundle: nil),
                           forCellReuseIdentifier: AnimationSpeedCell.identifier)
        tableView.register(UINib(nibName: ButtonCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ButtonCell.identifier)
        tableView.register(UINib(nibName: ComplexityDetailCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ComplexityDetailCell.identifier)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = sortingTypes[sorting.rawValue]
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let headerLabel = UILabel(frame: CGRect(x: 16, y: 0, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Arial-BoldMT", size: 22)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
}
