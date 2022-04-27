//
//  AppDelegate.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 20.01.2022.
//

import UIKit
import SwiftyVK

var vkDelegate : SwiftyVKDelegate?

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private lazy var rootFlowCoordinator: MainFlowCoordinator = {
        let fc = MainFlowCoordinator(parentViewController: nil, finishHandler: {})
        return fc
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        vkDelegate = VKDelegate()
        rootFlowCoordinator.parentViewController = vc
        rootFlowCoordinator.start(animated: true)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    @available(iOS 9.0, *)
         func application(
             _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:] ) -> Bool {
             let app = options[.sourceApplication] as? String
             VK.handle(url: url, sourceApplication: app)
             return true
         }
    
    func application(
               _ application: UIApplication,
               open url: URL,
               sourceApplication: String?,
               annotation: Any
           ) -> Bool {
               VK.handle(url: url, sourceApplication: sourceApplication)
               return true
           }
}
