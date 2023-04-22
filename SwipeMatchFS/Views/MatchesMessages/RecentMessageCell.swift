//
//  RecentMessageCell.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/04/22.
//

import UIKit
import LBTATools

class RecentMessageCell: LBTAListCell<RecentMessage> {
    
    let userProfileImageView = UIImageView(image: #imageLiteral(resourceName: "jane1.jpg"), contentMode: .scaleAspectFill)
    let usernameLabel = UILabel(text: "USERNAME HERE", font: .boldSystemFont(ofSize: 18), textColor: .label)
    let messageTextLabel = UILabel(text: "Some long line of text that should span 2 lines.", font: .systemFont(ofSize: 16), textColor: .systemGray, numberOfLines: 2)
    
    override var item: RecentMessage! {
        didSet {
            usernameLabel.text = item.name
            messageTextLabel.text = item.text
            userProfileImageView.sd_setImage(with: URL(string: item.profileImageUrl))
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        userProfileImageView.layer.cornerRadius = 94 / 2
        
        hstack(
            userProfileImageView.withWidth(94).withHeight(94),
            stack(
                usernameLabel,
                messageTextLabel,
                spacing: 2
            ),
            spacing: 20,
            alignment: .center
        ).padLeft(20).padRight(20)
        
        addSeparatorView(leadingAnchor: usernameLabel.leadingAnchor)
    }
}
