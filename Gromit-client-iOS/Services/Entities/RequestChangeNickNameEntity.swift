//
//  RequestChangeNickNameEntity.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/03/18.
//

import Foundation

struct RequestChangeNickNameMessage: Encodable {
    let nickname: String?
}

struct ResponseChangeNickNameMessage: Codable {
    let code: Int?
    let isSuccess: Bool?
    let message: String?
    let result: ChangeNickNameResult?
}

struct ChangeNickNameResult: Codable {
    let nickname: String?
}



//{
//    "isSuccess": true,
//    "code": 1000,
//    "message": "요청에 성공하였습니다.",
//    "result": {
//        "nickname": "kikkmmco"
//    }
//}
