//
//  CustomInputAccessoryView.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/04/17.
//

import UIKit
import LBTATools

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
