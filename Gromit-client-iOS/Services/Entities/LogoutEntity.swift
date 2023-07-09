//
//  LogoutEntity.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/04/09.
//

import Foundation

struct RequestLogoutMessage: Encodable {
    let deviceId: String?
    let accessToken: String?
}

struct ResponseLogoutMessage: Codable {
    let code: Int?
    let isSusccess: Bool?
    let message: String?
}
