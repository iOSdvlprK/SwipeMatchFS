//
//  SceneDelegate.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/03/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    @available(iOS 13.0, *)
    func customNavBarAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .clear
        
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        
        return appearance
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if #available(iOS 13.0, *) {
            let newNavBarAppearance = customNavBarAppearance()
            UINavigationBar.appearance().scrollEdgeAppearance = newNavBarAppearance
            UINavigationBar.appearance().compactAppearance = newNavBarAppearance
            UINavigationBar.appearance().standardAppearance = newNavBarAppearance
        }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = HomeController()
//        window.rootViewController = SwipingPhotosController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        window.makeKeyAndVisible()
        self.window = window
    }
}

