//
//  Gromit_client_iOSApp.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/21.
//

import SwiftUI
    
@main
struct Gromit_client_iOSApp: App {
    @UIApplicationDelegateAdaptor(LaunchScreenDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            RootCoordinatorView()
        }
    }
}
