//
//  AppDataService.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/03/18.
//

import Foundation

class AppDataService {
    static let shared = AppDataService()
    // UserDefaults.standard.string(forKey: "nickname")
    // UserDefaults.standard.set("APPLE", forKey: "provider")

    enum AppData: String {
        case provider, email, accessToken, refreshToken, githubUserName, gromitUserName, githubProfileImage
        
    }
    
    func setData(appData: AppData, value: String) {
        UserDefaults.standard.set(value, forKey: appData.rawValue)
    }
    
    func getData(appData: AppData) -> String? {
        return UserDefaults.standard.string(forKey: appData.rawValue)
    }
    
    func printInfo() {
        let provider = getData(appData: .provider)
        let email = getData(appData: .email)
        let accessToken = getData(appData: .accessToken)
        let refreshToken = getData(appData: .refreshToken)
        let githubUserName = getData(appData: .githubUserName)
        let githubProfileImage = getData(appData: .githubProfileImage)
        let gromitUserName = getData(appData: .gromitUserName)
        
        
        print("[ App Data Info ]")
        print("provider = \(provider), email = \(email), accessToken = \(accessToken), refreshToken = \(refreshToken), githubUserName = \(githubUserName). githubProfileImage = \(githubProfileImage), gromitUserName = \(gromitUserName)")
    }
    
    func removeToken() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
    }
    
    init() {
      
        
    }
}
