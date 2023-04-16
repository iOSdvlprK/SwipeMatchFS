//
//  MessagesNavBar.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/04/14.
//

import UIKit
import LBTATools

class MessagesNavBar: UIView {
    
//    let userProfileImageView = UIImageView(image: #imageLiteral(resourceName: "jane1.jpg"), contentMode: .scaleAspectFill)
    let userProfileImageView = CircularImageView(width: 44, image: #imageLiteral(resourceName: "jane1.jpg"))
    let nameLabel = UILabel(text: "USERNAME", font: .systemFont(ofSize: 16), textColor: .label)
    
    let backButton = UIButton(image: #imageLiteral(resourceName: "back"), tintColor: #colorLiteral(red: 0.9991757274, green: 0.418698281, blue: 0.4384849668, alpha: 1))
    let flagButton = UIButton(image: #imageLiteral(resourceName: "flag"), tintColor: #colorLiteral(red: 0.9991757274, green: 0.418698281, blue: 0.4384849668, alpha: 1))
    
    fileprivate let match: Match
    
    init(match: Match) {
        self.match = match
        
        nameLabel.text = match.name
        userProfileImageView.sd_setImage(with: URL(string: match.profileImageUrl))
        
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        setupShadow(opacity: 0.2, radius: 8, offset: CGSize(width: 0, height: 10), color: UIColor(white: 0, alpha: 0.3))
        
//        userProfileImageView.constrainWidth(44)
//        userProfileImageView.constrainHeight(44)
//        userProfileImageView.clipsToBounds = true
//        userProfileImageView.layer.cornerRadius = 44 / 2
        
        let middleStack = hstack(
            stack(
                userProfileImageView,
                nameLabel,
                spacing: 8,
                alignment: .center
            ),
            alignment: .center
        )
        
        hstack(
            backButton.withWidth(50),
            middleStack,
            flagButton
        ).withMargins(UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
