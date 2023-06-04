//
//  AppDataService.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/03/18.
//

import Foundation

class LoginService {
    static let shared = LoginService()
    
    var email: String?
    var accessToken: String?
    var refreshToken: String?
    var githubUserName: String?
    var githubUserImageUrl: String?
    var gromitUserName: String?

    func isExistLoginHistory() -> Bool {
        guard let accessToken = AppDataService.shared.getData(appData: .accessToken) else {
            return false
        }
        self.accessToken = accessToken

        guard let refreshToken = AppDataService.shared.getData(appData: .refreshToken) else {
            return false
        }
        self.refreshToken = refreshToken
        
        guard let email = AppDataService.shared.getData(appData: .email) else {
            return false
        }
        self.email = email
        
        return true
    }
    
    func setLoginInfo(email: String? = nil, accessToken: String? = nil, refreshToken: String? = nil, githubUserName: String? = nil, githubUserImageUrl: String? = nil, gromitUserName: String? = nil) {
        if let email = email {
            self.email = email
        }
        if let accessToken = accessToken {
            self.accessToken = accessToken
        }
        if let refreshToken = refreshToken {
            self.refreshToken = refreshToken
        }
        if let githubUserName = githubUserName {
            self.githubUserName = githubUserName
        }
        if let githubUserImageUrl = githubUserImageUrl {
            self.githubUserImageUrl = githubUserImageUrl
        }
        if let githubUserImageUrl = githubUserImageUrl {
            self.githubUserImageUrl = githubUserImageUrl
        }
        if let gromitUserName = gromitUserName {
            self.gromitUserName = gromitUserName
        }
    }
    
    func initLoginHistory() {
        AppDataService.shared.initData(appData: .email)
        AppDataService.shared.initData(appData: .accessToken)
        AppDataService.shared.initData(appData: .refreshToken)
        
    }
    
    func saveLoginHistory() {
        guard let email = self.email, let accessToken = self.accessToken, let refreshToken = self.refreshToken else {
            return
        }
        AppDataService.shared.setData(appData: .email, value: email)
        AppDataService.shared.setData(appData: .accessToken, value: accessToken)
        AppDataService.shared.setData(appData: .refreshToken, value: refreshToken)
        //AppDataService.shared.setData(appData: .githubUserName, value: githubUserName)

    }
    
    func getEmail() -> String? {
        return self.email
    }
    
    func getAccessToken() -> String? {
        return self.accessToken
    }
    
    func getRefreshToken() -> String? {
        return self.refreshToken
    }
    
    func getGithubUserName() -> String? {
        return self.githubUserName
    }
    
    func getGithubUserImageUrl() -> String? {
        return self.githubUserImageUrl
    }
    
    func getGromitUserName() -> String? {
        return self.gromitUserName
    }
    
    init() {
      
        
    }
}
