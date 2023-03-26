//
//  SignOutEntity.swift
//  Gromit-client-iOS
//
//  Created by 김진영 on 2023/03/16.
//

import Foundation

// MARK: - 애플 엑세스 토큰 발급 응답 모델
struct AppleTokenResponse: Codable {
    let refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
