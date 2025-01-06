//
//  SceneDelegate.swift
//  pokemon
//
//  Created by 반성준 on 12/31/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // UIWindowScene을 가져옵니다.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // UIWindow 설정
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = MainViewController() // 초기화면을 MainViewController로 설정
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
