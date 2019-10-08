//
//  ViewController.swift
//  figures
//
//  Created by Vladyslav PALAMARCHUK on 10/8/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        addOnView(point: sender.location(in: view))
        print("Tapped")
    }
    
    func addOnView(point: CGPoint) {
        if (animator == nil) {
            animator = UIDynamicAnimator(referenceView: view)
            collision = UICollisionBehavior()
            collision.translatesReferenceBoundsIntoBoundary = true
            gravity = UIGravityBehavior()
            animator?.addBehavior(self.gravity!)
            animator?.addBehavior(self.collision!)
        }
        addRect(point: point)
    }
    
    func addRect(point: CGPoint) {
        DispatchQueue.main.async {
            let square = UIView(frame: CGRect(x: point.x - 50, y: point.y - 50, width: 100, height: 100))
            square.backgroundColor = UIColor.red
            self.view.addSubview(square)
            self.gravity.addItem(square)
            self.collision.addItem(square)
        }
    }
}


