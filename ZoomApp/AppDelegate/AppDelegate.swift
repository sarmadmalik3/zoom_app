//
//  AppDelegate.swift
//  ZoomApp
//
//  Created by Sarmad Ishfaq on 06/06/2021.
//

import UIKit
import MobileRTC

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupSDK(sdkKey: Constants.sdkKey, sdkSecret: Constants.sdkSecret)
        navigateToInitialController()
        return true
    }


    func navigateToInitialController(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: StartMeetingController())
    }
    
    
    func setupSDK(sdkKey: String, sdkSecret: String) {
            let context = MobileRTCSDKInitContext()
            context.domain = "zoom.us"
            context.enableLog = true
            let sdkInitializedSuccessfully = MobileRTC.shared().initialize(context)

            if sdkInitializedSuccessfully == true, let authorizationService = MobileRTC.shared().getAuthService() {
                authorizationService.clientKey = sdkKey
                authorizationService.clientSecret = sdkSecret
                authorizationService.delegate = self
                authorizationService.sdkAuth()
            }
        }
    
}

//MARK:-RTC Delegate
extension AppDelegate : MobileRTCAuthDelegate {
    func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
        switch returnValue {
        case MobileRTCAuthError.success:
            print("SDK successfully initialized.")
        case MobileRTCAuthError.keyOrSecretEmpty:
            print("SDK Key/Secret was not provided. Replace sdkKey and sdkSecret at the top of this file with your SDK Key/Secret.")
        case MobileRTCAuthError.keyOrSecretWrong, MobileRTCAuthError.unknown:
            print("SDK Key/Secret is not valid.")
        default:
            print("SDK Authorization failed with MobileRTCAuthError: \(returnValue).")
        }
    }
    
    // Result of calling logIn(). 0 represents a successful log in attempt.
    func onMobileRTCLoginReturn(_ returnValue: Int) {
        switch returnValue {
        case 0:
            print("Successfully logged in")

            // This alerts the ViewController that log in was successful.
            NotificationCenter.default.post(name: Notification.Name("userLoggedIn"), object: nil)
        case 1002:
            print("Password incorrect")
        default:
            print("Could not log in. Error code: \(returnValue)")
        }
    }

    // Result of calling logoutRTC(). 0 represents a successful log out attempt.
    func onMobileRTCLogoutReturn(_ returnValue: Int) {
        switch returnValue {
        case 0:
            print("Successfully logged out")
        default:
            print("Could not log out. Error code: \(returnValue)")
        }
    }
}
