//
//  SendMessageButton.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/04/06.
//

import UIKit

class SendMessageButton: UIButton {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let gradientLayer = CAGradientLayer()
        let leftColor = UIColor(red: 255/255, green: 3/255, blue: 114/255, alpha: 1)
        let rightColor = UIColor(red: 255/255, green: 100/255, blue: 81/255, alpha: 1)
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
//        layer.addSublayer(gradientLayer)
        layer.insertSublayer(gradientLayer, at: 0)
        layer.cornerRadius = rect.height / 2
        clipsToBounds = true
        
        gradientLayer.frame = rect
    }

}
