//
//  SortingViewController.swift
//  SortingAlgorithms
//
//  Created by Maciej Kowalski on 26.08.2018.
//  Copyright © 2018 Maciej Kowalski. All rights reserved.
//

import UIKit

class SortingViewController: UITableViewController {
    
    fileprivate let reuseIdentifier = "SortingViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SortingViewCell
        cell.frame = CGRect(origin: cell.frame.origin, size: CGSize(width: view.frame.width, height: cell.frame.height))
        print(cell.frame)
        print(view.frame.width)
        cell.backgroundColor = .clear
        cell.sortingView.draw(array: [1,10,1,10,5])
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
