//
//  SignOutViewModel.swift
//  Gromit-client-iOS
//
//  Created by 김진영 on 2023/03/16.
//

import Foundation
import Alamofire
import AuthenticationServices

// MARK: - 애플 토큰 삭제 (탈퇴) HTTP 통신
class SignOutViewModel: ObservableObject {
    
    // MARK: - 애플 리프레시 토큰 발급
//    func getAppleRefreshToken(code: String, completionHandler: @escaping (AppleTokenResponse) -> Void) {
//        let url = "https://appleid.apple.com/auth/token"
//        let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
//        let parameters: Parameters = [
//            "client_id": "teamgromit.gromit",
//            "client_secret": "1번의jwt토큰",
//            "code": code,
//            "grant_type": "authorization_code"
//        ]
//
//        AF.request(url,
//                   method: .post,
//                   parameters: parameters,
//                   headers: header)
//        .validate(statusCode: 200..<600)
//        .responseData { response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//                let responseData = JSON(data)
//                print(responseData)
//
//                guard let output = try? JSONDecoder().decode(AppleTokenResponse.self, from: data) else {
//                    print("Error: JSON Data Parsing failed")
//                    return
//                }
//
//                completionHandler(output)
//            case .failure:
//                print("애플 토큰 발급 실패 - \(response.error.debugDescription)")
//            }
//        }
//    }
    
    func revokeAppleToken(clientSecret: String, token: String, completionHandler: @escaping () -> Void) {
        let url = "https://appleid.apple.com/auth/revoke"
        let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters: Parameters = [
            "client_id": "teamgromit.gromit",
            "client_secret": clientSecret,
            "token": token
        ]

        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   headers: header)
        .validate(statusCode: 200..<600)
        .responseData { response in
            guard let statusCode = response.response?.statusCode else { return }
            if statusCode == 200 {
                print("애플 토큰 삭제 성공!")
                completionHandler()
            }
        }
    }
}
