//
//  PhotoController.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/03/31.
//

import UIKit

class PhotoController: UIViewController {
    let imageView = UIImageView(image: UIImage(named: "kelly1")!)
    
    // provide an initializer that takes in a ULR instead
    init(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url)
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
