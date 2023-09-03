//
//  LaunchScreenAppDelegate.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/09/03.
//

import SwiftUI

class LaunchScreenDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions : [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Thread.sleep(forTimeInterval: 1)
        return true
    }
}
