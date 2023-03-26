//
//  ChallengesEntity.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/03/26.
//

import Foundation

struct ResponseAllChallengesMessage: Codable {
    let code: Int?
    let isSuccess: Bool?
    let message: String?
    let result: ChallengeResult
}

struct ChallengeResult: Codable {
    let title: String?
    let startDate: String?
    let goal: String?
    let recruits: String?
    let currentMemberNum: String?
    let passwd: String?
}
