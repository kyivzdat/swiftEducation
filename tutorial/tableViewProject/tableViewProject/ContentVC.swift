//
//  ContentVC.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 12/3/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class ContentVC: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subheaderLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var button: CustomButton!

    var header = ""
    var subheader = ""
    var imageName = ""
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = header
        subheaderLabel.text = subheader
        imageView.image = UIImage(named: imageName)
        button.setTitle((index == 0) ? "Next" : "Open", for: .normal)
        
        pageControl.numberOfPages = 2
        pageControl.currentPage = index
    }

    @IBAction func buttonClicked(_ sender: CustomButton) {
        switch index {
        case 0:
            if let pageVC = parent as? PageVC {
                pageVC.nextVC(atIndex: index)
            }
        case 1:
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "wasIntroWatched")
            userDefaults.synchronize()
            dismiss(animated: true)
        default:
            break
        }
    }
    
}
