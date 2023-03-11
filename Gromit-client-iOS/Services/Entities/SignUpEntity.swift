//
//  SignUpEntity.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/02/26.
//

import Foundation

struct RequestSignUpUser: Codable {
    let nickname, githubName, email, provider: String?
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let responseLoginMessage = try? JSONDecoder().decode(ResponseLoginMessage.self, from: jsonData)


// MARK: - ResponseLoginMessage
struct SignUpEntity: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: SignUpResponse?
}

// MARK: - Result
struct SignUpResponse: Codable {
    let userAccountID: Int?
    let accessToken, refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case userAccountID = "userAccountId"
        case accessToken, refreshToken
    }
}
