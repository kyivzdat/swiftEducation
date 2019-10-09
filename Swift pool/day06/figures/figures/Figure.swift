//
//  Figure.swift
//  figures
//
//  Created by Vladyslav PALAMARCHUK on 10/9/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

let colors : [UIColor] = [.magenta, .white, .yellow, .green, .cyan, .blue, .red, .orange, .purple, .darkGray]

class Figure: UIView {

    var type: String = "Rectangle"
    var collisionType: UIDynamicItemCollisionBoundsType = .rectangle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if (arc4random_uniform(2) == 0) {
            type = "Circle"
        }
        print("Init a new element - \(type)")
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 5
        backgroundColor = colors[Int.random(in: 0...9)]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return collisionType
    }
    
    override var bounds: CGRect {
        get {return super.bounds }
        set(newBounds) {
            super.bounds = newBounds
            if (self.type == "Circle") {
                layer.cornerRadius = newBounds.size.width / 2.0
                self.collisionType = .ellipse
            }
        }
    }

}
