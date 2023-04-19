//
//  MatchesMessagesController.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/04/08.
//

import UIKit
import LBTATools
import Firebase

class RecentMessageCell: LBTAListCell<UIColor> {
    
    let userProfileImageView = UIImageView(image: #imageLiteral(resourceName: "jane1.jpg"), contentMode: .scaleAspectFill)
    let usernameLabel = UILabel(text: "USERNAME HERE", font: .boldSystemFont(ofSize: 18))
    let messageTextLabel = UILabel(text: "Some long line of text that should span 2 lines.", font: .systemFont(ofSize: 16), textColor: .systemGray, numberOfLines: 2)
    
    override var item: UIColor! {
        didSet {
//            backgroundColor = item
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

class MatchesMessagesController: LBTAListHeaderController<RecentMessageCell, UIColor, MatchesHeader>, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func setupHeader(_ header: MatchesHeader) {
        header.matchesHorizontalController.rootMatchesController = self
    }
    
    func didSelectMatchFromHeader(match: Match) {
//        print("Select match:", match.name)
        let chatLogController = ChatLogController(match: match)
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    let customNavBar = MatchesNavBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [.systemRed, .systemBlue, .systemGreen, .systemPurple]
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        collectionView.backgroundColor = .systemBackground
        
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 150))
        
        collectionView.contentInset.top = 150
        collectionView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        
        let statusBarCover = UIView(backgroundColor: .systemBackground)
        view.addSubview(statusBarCover)
        statusBarCover.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}
