//
//  CardViewModel.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/03/06.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    // define the properties that view will display/render out
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}