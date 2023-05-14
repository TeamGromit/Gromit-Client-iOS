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
    
    func setLoginInfo(email: String, accessToken: String, refreshToken: String) {
        self.email = email
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        
        AppDataService.shared.setData(appData: .email, value: email)
        AppDataService.shared.setData(appData: .accessToken, value: accessToken)
        AppDataService.shared.setData(appData: .refreshToken, value: refreshToken)
    }
    
    init() {
      
        
    }
}
