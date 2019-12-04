//
//  MostPopularVC.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 12/4/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class MostPopularVC: UITableViewController {
    
    var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        spinner?.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        view.addSubview(spinner)
        
        //        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        //        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        NSLayoutConstraint(item: spinner!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: spinner!, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }
}
