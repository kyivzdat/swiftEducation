//
//  PageVC.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 12/3/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {
    
    let headersArray = ["Note", "Find it"]
    let subheadersArray = ["Make own list of favorite restaurants", "Find them on the map"]
    let imageArray = ["food", "iphoneMap"]

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstVC = displayViewController(atIndex: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
    
    func nextVC(atIndex index: Int) {
        if let contentVC = displayViewController(atIndex: index + 1) {
            setViewControllers([contentVC], direction: .forward, animated: true)
        }
    }
    
    func displayViewController(atIndex index: Int) -> ContentVC? {
        guard index >= 0, index < headersArray.count else { return nil}
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "contentViewController") as? ContentVC else { return nil }
        
        vc.header = headersArray[index]
        vc.subheader = subheadersArray[index]
        vc.imageName = imageArray[index]
        vc.index = index
        return vc
    }
}

extension PageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentVC).index
        index -= 1
        return displayViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentVC).index
        index += 1
        return displayViewController(atIndex: index)
    }
}
