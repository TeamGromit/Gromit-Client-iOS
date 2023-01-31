//
//  SearchGitUserEntity.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/30.
//

import Foundation

struct SearchGitUserEntity: Codable, CustomStringConvertible {
    var code: Int
    var isSuccess: Bool
    var message: String
    var result: SearchGitUserResponse
    
    var description: String {
        return "git user name: \(result.nickname) / image: \(result.img)"
    }
}

struct SearchGitUserResponse: Codable {
    var nickname: String
    var img: String
}
