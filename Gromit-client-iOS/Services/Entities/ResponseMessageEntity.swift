//
//  ResponseMessageEntity.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/04/01.
//

import Foundation

struct ResponseMessage<T: Codable>: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: T?
}


// MARK: - Result
struct CollectionResult: Codable {
    let chid: Int?
    let characterImg, totalSize, size: String?
}
