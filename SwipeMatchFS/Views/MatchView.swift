//
//  MatchView.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/04/05.
//

import UIKit

class MatchView: UIView {
    
    fileprivate let itsAMatchImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "itsamatch"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "You and X have liked\neach other"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let currentUserImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "kelly1"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    fileprivate let cardUserImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "jane1"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    fileprivate let sendMessageButton: UIButton = {
        let button = SendMessageButton(type: .system)
        button.setTitle("SEND MESSAGE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    fileprivate let keepSwipingButton: UIButton = {
        let button = KeepSwipingButton(type: .system)
        button.setTitle("Keep Swiping", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBlurView()
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        addSubview(itsAMatchImageView)
        addSubview(descriptionLabel)
        addSubview(currentUserImageView)
        addSubview(cardUserImageView)
        addSubview(sendMessageButton)
        addSubview(keepSwipingButton)
        
        let imageWidth: CGFloat = 140
        
        itsAMatchImageView.anchor(top: nil, leading: leadingAnchor, bottom: descriptionLabel.topAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 50, bottom: 30, right: 50), size: CGSize(width: 300, height: 80))
        itsAMatchImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        descriptionLabel.anchor(top: nil, leading: leadingAnchor, bottom: currentUserImageView.topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0), size: CGSize(width: 0, height: 50))
        
        currentUserImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: centerXAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16), size: CGSize(width: imageWidth, height: imageWidth))
        currentUserImageView.layer.cornerRadius = imageWidth / 2
        currentUserImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        cardUserImageView.anchor(top: nil, leading: centerXAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0), size: CGSize(width: imageWidth, height: imageWidth))
        cardUserImageView.layer.cornerRadius = imageWidth / 2
        cardUserImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        sendMessageButton.anchor(top: currentUserImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 32, left: 50, bottom: 0, right: 50), size: CGSize(width: 0, height: 60))
        
        keepSwipingButton.anchor(top: sendMessageButton.bottomAnchor, leading: sendMessageButton.leadingAnchor, bottom: nil, trailing: sendMessageButton.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 60))
    }
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    fileprivate func setupBlurView() {
        visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        visualEffectView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.visualEffectView.alpha = 1
        }
    }
    
    @objc fileprivate func handleTapDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
