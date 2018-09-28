//
//  SettingsTableViewController.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 14.09.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    fileprivate let pickValueCellReuseIdentifier = "PickValueCell"
    
    override func viewDidLoad() {
        let nib = UINib(nibName: pickValueCellReuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: pickValueCellReuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pickValueCellReuseIdentifier, for: indexPath) as! PickValueCell
        cell.textLabel?.text = "Number of items to sort"
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        cell.segmentedControl.removeAllSegments()
        cell.segmentedControl.insertSegment(withTitle: "10", at: 0, animated: false)
        cell.segmentedControl.insertSegment(withTitle: "100", at: 1, animated: false)
        cell.segmentedControl.insertSegment(withTitle: "1000", at: 2, animated: false)
        cell.segmentedControl.tintColor = .orange
        
        return cell
        
    }
    
}
