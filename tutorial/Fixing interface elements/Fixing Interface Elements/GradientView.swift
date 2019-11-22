
//
//  GradientView.swift
//  Fixing Interface Elements
//
//  Created by Vladyslav PALAMARCHUK on 11/22/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable private var startColor: UIColor = .clear {
        didSet {
            gradientLayer.colors?[0] = startColor.cgColor
        }
    }
    
    @IBInspectable private var startPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            gradientLayer.startPoint = startPoint
        }
    }
    
    @IBInspectable private var endColor: UIColor  = .clear {
        didSet {
            gradientLayer.colors?[1] = endColor.cgColor
        }
    }
    
    @IBInspectable private var endPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            gradientLayer.endPoint = endPoint
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
//        self.layer.addSublayer(gradientLayer)
        self.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
    }
}
