//
//  SignInEntity.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/30.
//

import Foundation

struct SignInEntity: Codable, CustomStringConvertible {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: LoginWithAppleResponse
    
    var description: String {
        return "git user name: \(result.nickname) / message: \(message)"
    }
}

struct LoginWithAppleResponse: Codable {
    // 기존 회원시
    let accessToken, refreshToken: String?
    // 신규 회원시
    let email, provider: String?
}
