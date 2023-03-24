//
//  CustomTextField.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/03/10.
//

import UIKit

class CustomTextField: UITextField {
    
    let padding: CGFloat
    let height: CGFloat
    
    init(padding: CGFloat, height: CGFloat) {
        self.padding = padding
        self.height = height
        super.init(frame: .zero)
        layer.cornerRadius = height / 2
        backgroundColor = .systemBackground
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
