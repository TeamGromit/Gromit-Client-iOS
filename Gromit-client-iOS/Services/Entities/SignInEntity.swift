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
    let result: SignInResponse
    
    var description: String {
        return "sign in: \(message), user account id: \(result.userAccountId)"
    }
}

struct SignInResponse: Codable {
    let userAccountId, accessToken, refreshToken: String
}


