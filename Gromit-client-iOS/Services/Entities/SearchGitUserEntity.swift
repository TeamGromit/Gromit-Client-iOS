//
//  SearchGitUserEntity.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/30.
//

import Foundation

struct SearchGitUserEntity: Decodable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: SearchGitUserResponse
}

struct SearchGitUserResponse: Decodable, Hashable {
    let githubNickname, img: String
}
