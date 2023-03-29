//
//  SwipingPhotosController.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/03/28.
//

import UIKit

class SwipingPhotosController: UIPageViewController, UIPageViewControllerDataSource {
    
    var cardViewModel: CardViewModel! {
        didSet {
            print(cardViewModel.attributedString)
            controllers = cardViewModel.imageUrls.map { imageUrl -> UIViewController in
                let photoController = PhotoController(imageUrl: imageUrl)
                return photoController
            }
            
            setViewControllers([controllers.first!], direction: .forward, animated: true)
        }
    }
    
//    let controllers = [
//        PhotoController(image: UIImage(named: "boost_circle")!),
//        PhotoController(image: UIImage(named: "refresh_circle")!),
//        PhotoController(image: UIImage(named: "like_circle")!),
//        PhotoController(image: UIImage(named: "super_like_circle")!),
//        PhotoController(image: UIImage(named: "dismiss_circle")!)
//    ]
    
    var controllers = [UIViewController]()  // blank array

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        view.backgroundColor = .systemBackground
        
//        setViewControllers([controllers.first!], direction: .forward, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: { $0 == viewController }) ?? 0
        if index == controllers.count - 1 { return nil }
        return controllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: { $0 == viewController }) ?? 0
        if index == 0 { return nil }
        return controllers[index - 1]
    }
}

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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
