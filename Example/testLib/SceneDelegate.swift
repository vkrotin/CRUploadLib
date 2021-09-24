//
//  SceneDelegate.swift
//  testLib
//
//  Created by  vkrotin on 22.09.2021.
//

import UIKit
import CRUploadLib

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        UploadManager.shared.endBackgroundTask()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        UploadManager.shared.registerBackgroundTask()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

