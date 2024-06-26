//
//  AppDelegate.swift
//  BBangChinJa
//
//  Created by Dahlia on 5/9/24.
//

import UIKit

import FirebaseCore
import NMapsMap
import KakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	let id = Bundle.main.idKey
	let kakaoId = Bundle.main.kakao
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		FirebaseApp.configure()
		NMFAuthManager.shared().clientId = id
		KakaoSDK.initSDK(appKey: kakaoId)
		return true
	}
	
	// MARK: UISceneSession Lifecycle
	
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}
	
	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		
	}
	
}

