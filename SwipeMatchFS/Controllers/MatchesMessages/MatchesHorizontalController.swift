//
//  MatchesHorizontalController.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/04/19.
//

import UIKit
import LBTATools
import Firebase

class MatchesHorizontalController: LBTAListController<MatchCell, Match>, UICollectionViewDelegateFlowLayout {
    
    weak var rootMatchesController: MatchesMessagesController?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let match = self.items[indexPath.item]
        rootMatchesController?.didSelectMatchFromHeader(match: match)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 16)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        fetchMatches()
    }
    
    fileprivate func fetchMatches() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("matches_messages").document(currentUserId).collection("matches").getDocuments { querySnapshot, err in
            if let err = err {
                print("Failed to fetch matches:", err)
                return
            }
            print("Here are my matches documents")
            
            var matches = [Match]()
            querySnapshot?.documents.forEach { documentSnapshot in
                let dictionary = documentSnapshot.data()
                matches.append(Match(dictionary: dictionary))
            }
            self.items = matches
            self.collectionView.reloadData()
        }
    }
}
