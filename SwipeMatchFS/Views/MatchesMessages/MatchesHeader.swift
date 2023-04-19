//
//  MatchesHeader.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/04/19.
//

import UIKit
import LBTATools

class MatchesHeader: UICollectionReusableView {
    
    let newMatchesLabel = UILabel(text: "New Matches", font: .boldSystemFont(ofSize: 16), textColor: #colorLiteral(red: 0.9991758466, green: 0.418698132, blue: 0.4339716733, alpha: 1))
    
    let matchesHorizontalController = MatchesHorizontalController()
    
    let messagesLabel = UILabel(text: "Messages", font: .boldSystemFont(ofSize: 16), textColor: #colorLiteral(red: 0.9991758466, green: 0.418698132, blue: 0.4339716733, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stack(
            stack(newMatchesLabel).padLeft(20),
            matchesHorizontalController.view,
            stack(messagesLabel).padLeft(20),
            spacing: 20
        ).withMargins(UIEdgeInsets(top: 20, left: 0, bottom: 8, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
