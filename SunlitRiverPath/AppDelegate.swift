//
//  AppDelegate.swift
//  SunlitRiverPath
//
//  Created by Developer on 7.03.26.
//

import SwiftUI
import UIKit

class ShadowsChaseLightAppDelegate: NSObject, UIApplicationDelegate {

    static var orientationShadowsChaseLight = UIInterfaceOrientationMask.portrait {
        didSet {
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return ShadowsChaseLightAppDelegate.orientationShadowsChaseLight
    }
}
