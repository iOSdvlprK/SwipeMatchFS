//
//  MatchesMessagesController.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/04/08.
//

import UIKit
import LBTATools

class MatchesMessagesController: UICollectionViewController {
    
    let customNavBar: UIView = {
        let navBar = UIView(backgroundColor: .systemBackground)
        
        let iconImageView = UIImageView(image: UIImage(named: "top_messages_icon")?.withRenderingMode(.alwaysTemplate), contentMode: .scaleAspectFit)
        iconImageView.tintColor = #colorLiteral(red: 0.9991757274, green: 0.418698281, blue: 0.4384849668, alpha: 1)
        let messagesLabel = UILabel(text: "Messages", font: .boldSystemFont(ofSize: 20), textColor: #colorLiteral(red: 0.9991757274, green: 0.418698281, blue: 0.4384849668, alpha: 1), textAlignment: .center)
        let feedLabel = UILabel(text: "Feed", font: .boldSystemFont(ofSize: 20), textColor: .systemGray, textAlignment: .center)
        
        navBar.setupShadow(opacity: 0.2, radius: 8, offset: CGSize(width: 0, height: 10), color: UIColor(white: 0, alpha: 0.3))
        
        navBar.stack(iconImageView.withHeight(44), navBar.hstack(messagesLabel, feedLabel, distribution: .fillEqually)).padTop(10)
        
        return navBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 150))
    }
}
