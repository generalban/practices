//
//  AppDelegate.swift
//  pokemon
//
//  Created by 반성준 on 12/31/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 디버깅 메시지 추가
        print("AppDelegate didFinishLaunchingWithOptions called")
        
        // iOS 12 이하 호환을 위해 window 설정
        if #available(iOS 13.0, *) {
            // SceneDelegate 사용
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = MainViewController()
            window?.makeKeyAndVisible()
        }

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        print("AppDelegate configurationForConnecting called")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print("AppDelegate didDiscardSceneSessions called")
    }
}
