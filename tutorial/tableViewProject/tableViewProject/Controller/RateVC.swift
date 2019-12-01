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
        let elementArray = [textLabel, dislikeButton, likeDislikeButton, likeButton]
        for element in elementArray {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                element?.transform = .identity
            })
        }
    }
    
    @IBAction func tapRate(sender: UIButton) {
        
//        var buttonSize: [[CGFloat]] = Array(repeating: [1, 1], count: 3)
        var buttonSize: [UIButton: [CGFloat]] = [dislikeButton: [1, 1],
                          likeDislikeButton: [1, 1],
                          likeButton: [1, 1]]
        let buttonArray = [dislikeButton, likeDislikeButton, likeButton]
        
        switch sender.tag {
        case 0:
            buttonSize[likeDislikeButton] = [1, 1]
            buttonSize[likeButton] = [1, 1]
            buttonSize[dislikeButton] = (rate == "dislike") ? [1, 1] : [1.3, 1.3]
            rate = (rate == "dislike") ? nil : "dislike"
        case 1:
            buttonSize[dislikeButton] = [1, 1]
            buttonSize[likeButton] = [1, 1]
            buttonSize[likeDislikeButton] = (rate == "like_dislike") ? [1, 1] : [1.3, 1.3]
            rate = (rate == "like_dislike") ? nil : "like_dislike"
        case 2:
            buttonSize[dislikeButton] = [1, 1]
            buttonSize[likeDislikeButton] = [1, 1]
            buttonSize[likeButton] = (rate == "like") ? [1, 1] : [1.3, 1.3]
            rate = (rate == "like") ? nil : "like"
        default: break
        }
        
        for button in buttonArray {
            if let xy = buttonSize[button!] {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    button?.transform = CGAffineTransform(scaleX: xy[0], y: xy[1])
                })
            }
        }
        
        
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
