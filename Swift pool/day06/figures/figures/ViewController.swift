//
//  ViewController.swift
//  figures
//
//  Created by Vladyslav PALAMARCHUK on 10/8/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var figures : [Figure] = []
    var select : Figure? = nil
    
    
    var animator: UIDynamicAnimator!
    var gravity = UIGravityBehavior()
    var collision = UICollisionBehavior()
    let behaviour = UIDynamicItemBehavior()
    let motionManager = CMMotionManager()
    let motionQueue = OperationQueue.main

    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapAction(_:)))
        view.addGestureRecognizer(tap)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panGesture(_:)))
        view.addGestureRecognizer(pan)
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.pinchAction(_:)))
        view.addGestureRecognizer(pinch)
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.rotationAction(_:)))
        view.addGestureRecognizer(rotation)
    
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior()
        gravity.gravityDirection = CGVector(dx:0, dy: 0.8)
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)

        behaviour.elasticity = 0.7
        animator.addBehavior(behaviour)
    
    }

    override func viewDidAppear(_ animated: Bool) {
        if motionManager.isAccelerometerAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: motionQueue, withHandler: gravityUpdated as! CMDeviceMotionHandler)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        motionManager.stopDeviceMotionUpdates()
    }
    
    func gravityUpdated(motion: CMDeviceMotion!, error: NSError!) {
        if (error != nil) {
            NSLog("\(String(describing: error))")
        }
        let grav : CMAcceleration = motion.gravity;
        
        let x = CGFloat(grav.x)
        let y = CGFloat(grav.y)
        let v = CGVector(dx: x,dy: y)
        gravity.gravityDirection = v
    }
    
    @IBAction func rotationAction(_ sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for form in figures {
                if (form.layer.presentation()?.frame.contains(tapLocation))! {
                    select = form
                    break
                }
            }
            if select != nil {
                gravity.removeItem(select!)
                collision.removeItem(select!)
                behaviour.removeItem(select!)
                self.view.bringSubviewToFront(select!)
            }
        case .changed:
            if select != nil {

                select!.transform = select!.transform.rotated(by: sender.rotation)
                animator.updateItem(usingCurrentState: select!)
                sender.rotation = 0

            }
        default:
            if select != nil {
                gravity.addItem(select!)
                collision.addItem(select!)
                behaviour.addItem(select!)
                select = nil
            }
        }
        if select != nil {
            print("Rotating \(select!.type)")
        }
    }

    @IBAction func pinchAction(_ sender: UIPinchGestureRecognizer) {
        var lastdist: CGFloat = 1
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for form in figures {
                if (form.layer.presentation()?.frame.contains(tapLocation))! {
                    select = form
                    break
                }
            }
            if select != nil {
                self.view.bringSubviewToFront(select!)
                lastdist = sender.scale
            }
        case .changed:
            if select != nil {
                gravity.removeItem(select!)
                collision.removeItem(select!)
                behaviour.removeItem(select!)
                select!.bounds.size = CGSize(width: 100 * (sender.scale/lastdist),
                                             height: 100 * (sender.scale/lastdist))
                animator.updateItem(usingCurrentState: select!)
                collision.addItem(select!)
                behaviour.addItem(select!)
                gravity.addItem(select!)
            }
        default:
            if select != nil {
                collision.addItem(select!)
                behaviour.addItem(select!)
                gravity.addItem(select!)
                select = nil
            }
        }
        if select != nil {
            print("Pinching \(select!.type)")
        }
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for form in figures {
                if (form.layer.presentation()?.frame.contains(tapLocation))! {
                    select = form
                    break
                }
            }
            if select != nil {
                self.view.bringSubviewToFront(select!)
                gravity.removeItem(select!)
                collision.removeItem(select!)
            }
        case .changed:
            if select != nil {
                select!.center = sender.location(in: self.view)
                animator.updateItem(usingCurrentState: select!)
            }
        default:
            if select != nil {
                gravity.addItem(select!)
                collision.addItem(select!)
                select = nil
            }
        }
        if select != nil {
            print("Dragging \(select!.type)")
        }
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            let newElement = Figure()
            newElement.translatesAutoresizingMaskIntoConstraints = true
            newElement.center = sender.location(in: self.view)
            figures.append(newElement)
            self.view.addSubview(newElement)
            
            newElement.bounds.size = CGSize(width: 100, height: 100)
            // Call override var collisionBoundsType
            gravity.addItem(newElement)
            collision.addItem(newElement)
            behaviour.addItem(newElement)
        default:
            break
        }
        print("Tapped")
    }
    

}

