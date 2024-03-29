//
//  ChatLogController.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/04/13.
//

import UIKit
import LBTATools
import Firebase

class ChatLogController: LBTAListController<MessageCell, Message>, UICollectionViewDelegateFlowLayout {
    
    deinit {
        print("CHATLOGCONTROLLER ----- Object is destroying itself properly, no retain cycles or any other memory related issues. Memory being reclaimed properly")
    }
    
    fileprivate lazy var customNavBar = MessagesNavBar(match: match)
    
    fileprivate let navBarHeight: CGFloat = 120
    
    fileprivate let match: Match
    
    init(match: Match) {
        self.match = match
        super.init()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    lazy var customInputView: CustomInputAccessoryView = {
        let civ = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        civ.sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return civ
    }()
    
    @objc fileprivate func handleSend() {
        print(customInputView.textView.text ?? "")
        
        saveToFromMessages()
        saveToFromRecentMessages()
    }
    
    fileprivate func saveToFromRecentMessages() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        let data: [String: Any] = ["text": customInputView.textView.text ?? "", "name": match.name, "profileImageUrl": match.profileImageUrl, "timestamp": Timestamp(date: Date()), "uid": match.uid]
        
        Firestore.firestore().collection("matches_messages").document(currentUserId).collection("recent_messages").document(match.uid).setData(data) { err in
            // check your err if any
            if let err = err {
                print("Failed to save recent message:", err)
                return
            }
            print("Saved recent message")
        }
        
        // save the other direction
        guard let currentUser = self.currentUser else { return }
        let toData: [String: Any] = ["text": customInputView.textView.text ?? "", "name": currentUser.name ?? "", "profileImageUrl": currentUser.imageUrl1 ?? "", "timestamp": Timestamp(date: Date()), "uid": currentUserId]
        
        Firestore.firestore().collection("matches_messages").document(match.uid).collection("recent_messages").document(currentUserId).setData(toData)
    }
    
    fileprivate func saveToFromMessages() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let collection =  Firestore.firestore().collection("matches_messages").document(currentUserId).collection(match.uid)
        
        let data: [String: Any] = ["text": customInputView.textView.text ?? "", "fromId": currentUserId, "toId": match.uid, "timestamp": Timestamp(date: Date())]
        
        collection.addDocument(data: data) { err in
            if let err = err {
                print("Failed to save message:", err)
                return
            }
            
            print("Successfully saved msg into Firestore")
            self.customInputView.textView.text = nil
            self.customInputView.placeholderLabel.isHidden = false
        }
        
        // will also save data to the other side
        let toCollection =  Firestore.firestore().collection("matches_messages").document(match.uid).collection(currentUserId)    // reverse
        
        toCollection.addDocument(data: data) { err in
            if let err = err {
                print("Failed to save message:", err)
                return
            }
            
            print("Successfully saved msg into Firestore")
            self.customInputView.textView.text = nil
            self.customInputView.placeholderLabel.isHidden = false
        }
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return customInputView
        }
    }
    
    var listener: ListenerRegistration?
    
    fileprivate func fetchMessages() {
        print("Fetching messages")
        
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let query = Firestore.firestore().collection("matches_messages").document(currentUserId).collection(match.uid).order(by: "timestamp")
        
        listener = query.addSnapshotListener { querySnapshot, err in
            if let err = err {
                print("Failed to fetch messages:", err)
                return
            }
            
            querySnapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    self.items.append(Message(dictionary: dictionary))
                }
                
                self.collectionView.reloadData()
                self.collectionView.scrollToItem(at: [0, self.items.count - 1], at: .bottom, animated: true)
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // tells you if it's being popped off the nav stack
        if isMovingFromParent {
            listener?.remove()
        }
    }
    
    var currentUser: User?
    
    fileprivate func fetchCurrentUser() {
        Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "").getDocument { snapshot, err in
            let data = snapshot?.data() ?? [:]
            self.currentUser = User(dictionary: data)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrentUser()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        collectionView.keyboardDismissMode = .interactive
        
        fetchMessages()
        
        setupUI()
    }
    
    @objc fileprivate func handleKeyboardShow() {
        self.collectionView.scrollToItem(at: [0, items.count - 1], at: .bottom, animated: true)
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
