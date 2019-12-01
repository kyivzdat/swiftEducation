//
//  CustomButton.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 12/1/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomButton: UIButton {
    
    @IBInspectable var customBGColor: UIColor = .clear {
        didSet {
            layer.backgroundColor = customBGColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = self.borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = self.borderColor.cgColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setValue()
    }

    override func prepareForInterfaceBuilder() {
        setValue()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setValue()
    }

    private func setValue() {
        layer.backgroundColor = customBGColor.cgColor
        layer.cornerRadius = self.cornerRadius
        layer.borderWidth = self.borderWidth
        layer.borderColor = self.borderColor.cgColor
        clipsToBounds = true
    }
}
