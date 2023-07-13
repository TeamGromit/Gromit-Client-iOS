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
class SettingViewModel: ObservableObject {
    enum OutputEvent {
        case reqeustError, signOut
    }
    
    @Published var outputEvent: OutputEvent? = nil
    
    func signOut() {
        guard let token = LoginService.shared.accessToken else {
            print("Guard Error token is nil")
            return
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-AUTH-TOKEN": token
        ]
        NetworkingClinet.shared.request(serviceURL: .reqeustSignOut, httpMethod: .delete, headers: headers, type: ResponseSignOutMessage.self) { responseData, error in
            if let error = error {
                
            } else {
                if let responseData = responseData, let responseMessage = responseData.1, let response = responseData.0{
                    print(response)
                    if(responseMessage.code == 1000) {
                        print("탈퇴 완료!")
                        self.outputEvent = .signOut
                    } else {
                        print("탈퇴 실패!")
                        self.outputEvent = .reqeustError
                    }
                }
            }
        }
    }
}

struct ResponseSignOutMessage: Codable {
    let code: Int?
    let isSuccess: Bool?
    let message: String?
    let result: String?
}
