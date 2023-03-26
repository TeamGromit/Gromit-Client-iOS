//
//  CreationEntity.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/03/22.
//

import Foundation

struct RequestCreationMessage: Encodable {
    let title: String?
    let startDate: String?
    let endDate: String?
    let goal: Int?
    let recruits: Int?
    let isPassword: Bool?
    let password: String?
}


// MARK: - ResponseLoginMessage
struct ResponseCreationMessage: Codable {
    let code: Int?
    let isSuccess: Bool?
    let message: String?
    let result: String?
}
