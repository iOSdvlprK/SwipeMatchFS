//
//  CardView.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/03/04.
//

import UIKit

class CardView: UIView {
    
    fileprivate let imageView = UIImageView(image: UIImage(named: "lady5c"))
    
    // Configurations
    fileprivate let threshold: CGFloat = 80

    override init(frame: CGRect) {
        super.init(frame: frame)
        // custom drawing code
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
//        let translation = gesture.translation(in: nil)
//        self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        
        // rotation
        let translation = gesture.translation(in: nil)
        let degree: CGFloat = translation.x / 20
        let radian = degree * .pi / 180 // rad ← degrees
        let rotationTransformation = CGAffineTransform(rotationAngle: radian)
        self.transform = rotationTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
            if shouldDismissCard {
                let offScreenTransform = self.transform.translatedBy(x: 1000 * translationDirection, y: 0)
                self.transform = offScreenTransform
//                self.frame = CGRect(x: 1000 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }
        } completion: { _ in
            self.transform = .identity
//            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
