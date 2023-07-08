//
//  InputUserNicknameEntity.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/02/02.
//

import Foundation

struct InputUserNameEntity: Codable, CustomStringConvertible {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: GromitNickNameResponse?
    
    var description: String {
        guard let result = result else {
            return "gromit user name: nil / message: \(message)"
        }
        return "gromit user name: \(result.nickname) / message: \(message)"
    }
}

struct GromitNickNameResponse: Codable {
    var nickname: String
}
