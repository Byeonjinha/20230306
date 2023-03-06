//
//  SceneDelegate.swift
//  20230306
//
//  Created by Byeon jinha on 2023/03/06.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        setRootViewController(scene)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Use this method to save data, release shared resources, and store enough scene-specific state information to restore the scene back to its current state.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

extension SceneDelegate {
    private func setRootViewController(_ scene: UIScene) {
        setRootViewController(scene, viewController: ViewController())
    }
    
    private func setRootViewController(_ scene: UIScene, viewController: UIViewController) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let rootNavigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController = rootNavigationController
            self.window = window
            self.window?.makeKeyAndVisible()
        }
    }
}
