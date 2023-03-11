// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let responseLoginMessage = try? JSONDecoder().decode(ResponseLoginMessage.self, from: jsonData)

import Foundation

// MARK: - ResponseLoginMessage
struct RequestLoginMessage: Encodable {
    let token: String?
}


// MARK: - ResponseLoginMessage
struct ResponseLoginMessage: Codable {
    let code: Int?
    let isSuccess: Bool?
    let message: String?
    let result: Result?
}

// MARK: - Result
struct Result: Codable {
    let email, provider: String?
}

