//
//  RateVC.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 11/26/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class RateVC: UIViewController {

    @IBOutlet weak var rateStack: UIStackView!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeDislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    var rate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dislikeButton.transform = CGAffineTransform(translationX: -200, y: 0)
        likeDislikeButton.transform = CGAffineTransform(rotationAngle: .pi)
        likeButton.transform = CGAffineTransform(translationX: 200, y: 0)
        textLabel.transform = CGAffineTransform(scaleX: 0, y: 0)

        setButtonColor()
        addBlurEffect()
        
    }

    override func viewDidAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 0.4) {
//            self.rateStack.transform = CGAffineTransform(scaleX: 1, y: 1)
//        }
        let elementArray = [textLabel, dislikeButton, likeDislikeButton, likeButton]
        for element in elementArray {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                element?.transform = .identity
            })
        }
    }
    
    @IBAction func tapRate(sender: UIButton) {
        
        switch sender.tag {
        case 0: rate = "dislike"
        case 1: rate = "like_dislike"
        case 2: rate = "like"
        default: break
        }
        performSegue(withIdentifier: "unwindSegueToDetail", sender: sender)
    }
    
    func setButtonColor() {
        let buttonImage = UIImage(named: "exit")
        let tintedImage = buttonImage?.withRenderingMode(.alwaysTemplate)
        exitButton.setImage(tintedImage, for: .normal)
        exitButton.tintColor = .red
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.insertSubview(blurEffectView, at: 1)
    }

}
