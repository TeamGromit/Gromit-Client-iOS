//
//  ResultEntity.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/03/24.
//

import Foundation

struct Result: Codable {
    let email, provider: String?
    let accessToken, refreshToken: String?
    
    let commits, todayCommit, level, goal: Int?
    let name, img: String?
}
