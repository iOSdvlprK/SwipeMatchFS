//
//  MatchesNavBar.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/04/10.
//

import UIKit
import LBTATools

class MatchesNavBar: UIView {
    
    let backButton = UIButton(image: #imageLiteral(resourceName: "app_icon"), tintColor: .systemGray4)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        let iconImageView = UIImageView(image: UIImage(named: "top_messages_icon")?.withRenderingMode(.alwaysTemplate), contentMode: .scaleAspectFit)
        iconImageView.tintColor = #colorLiteral(red: 0.9991757274, green: 0.418698281, blue: 0.4384849668, alpha: 1)
        let messagesLabel = UILabel(text: "Messages", font: .boldSystemFont(ofSize: 20), textColor: #colorLiteral(red: 0.9991757274, green: 0.418698281, blue: 0.4384849668, alpha: 1), textAlignment: .center)
        let feedLabel = UILabel(text: "Feed", font: .boldSystemFont(ofSize: 20), textColor: .systemGray, textAlignment: .center)
        
        setupShadow(opacity: 0.2, radius: 8, offset: CGSize(width: 0, height: 10), color: UIColor(white: 0, alpha: 0.3))
        
        stack(iconImageView.withHeight(44), hstack(messagesLabel, feedLabel, distribution: .fillEqually)).padTop(10)
        
        addSubview(backButton)
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 0), size: CGSize(width: 34, height: 34))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
