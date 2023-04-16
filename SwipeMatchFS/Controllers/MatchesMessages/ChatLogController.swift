//
//  ChatLogController.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/04/13.
//

import UIKit
import LBTATools

class ChatLogController: LBTAListController<MessageCell, Message>, UICollectionViewDelegateFlowLayout {
    
    fileprivate lazy var customNavBar = MessagesNavBar(match: match)
    
    fileprivate let navBarHeight: CGFloat = 120
    
    fileprivate let match: Match
    
    init(match: Match) {
        self.match = match
        super.init()
    }
    
    // input accessory view
    
    class CustomInputAccessoryView: UIView {
        
        let textView = UITextView()
        let sendButton = UIButton(title: "SEND", titleColor: .label, font: .boldSystemFont(ofSize: 14), backgroundColor: .systemBackground, target: nil, action: nil)
        
        let placeholderLabel = UILabel(text: "Enter Message", font: .systemFont(ofSize: 16), textColor: .systemGray)
        
        override var intrinsicContentSize: CGSize {
            return .zero
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .systemBackground
            setupShadow(opacity: 0.1, radius: 8, offset: CGSize(width: 0, height: -8), color: .systemGray)
            autoresizingMask = .flexibleHeight
            
            textView.isScrollEnabled = false
            textView.font = .systemFont(ofSize: 16)
            
            NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
            
            hstack(
                textView,
                sendButton.withSize(CGSize(width: 60, height: 60)),
                alignment: .center
            ).withMargins(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
            
            addSubview(placeholderLabel)
            placeholderLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: sendButton.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
            placeholderLabel.centerYAnchor.constraint(equalTo: sendButton.centerYAnchor).isActive = true
        }
        
        @objc fileprivate func handleTextChange() {
            placeholderLabel.isHidden = textView.text.count != 0
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    lazy var redView: UIView = {
        return CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return redView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.keyboardDismissMode = .interactive
        
        items = [
            .init(text: "Excellence is an art won by training and habituation. We do not act rightly because we have virtue or excellence, but we rather have those because we have acted rightly. We are what we repeatedly do. Excellence, then, is not an act but a habit.", isFromCurrentLoggedUser: true),
            .init(text: "Hello bud", isFromCurrentLoggedUser: false),
            .init(text: "Hello from LBTAListController", isFromCurrentLoggedUser: true),
            .init(text: "Follow excellence.\nAnd success will follow you!", isFromCurrentLoggedUser: false),
            .init(text: "Gratitude and attitude are not challenges, they are choices.", isFromCurrentLoggedUser: true),
            .init(text: "Once or twice in life, someone will give you a shot you don't quite deserve. Work 100 hours. Do whatever it takes. Make it happen.", isFromCurrentLoggedUser: false),
            .init(text: "Your mind is like this water, my friend. When it is agitated, it becomes difficult to see. But if you allow it to settle, the answer becomes clear.", isFromCurrentLoggedUser: true),
            .init(text: "You are too concerned with what was and what will be. There is a saying: Yesterday is history, tomorrow is a mystery, but today is a gift. That is why it is called the present.", isFromCurrentLoggedUser: false)
        ]
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        collectionView.alwaysBounceVertical = true
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: navBarHeight))
        
        collectionView.contentInset.top = navBarHeight
//        collectionView.scrollIndicatorInsets.top = navBarHeight
        collectionView.verticalScrollIndicatorInsets = UIEdgeInsets(top: navBarHeight, left: 0, bottom: 0, right: 0)
        
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        let statusBarCover = UIView(backgroundColor: .systemBackground)
        view.addSubview(statusBarCover)
        statusBarCover.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // estimated sizing
        let estimatedSizeCell = MessageCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1000))   // using a dummy cell
        estimatedSizeCell.item = self.items[indexPath.item]
        estimatedSizeCell.layoutIfNeeded()
        
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: 1000))
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
