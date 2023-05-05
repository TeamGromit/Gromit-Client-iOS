//
//  SignInViewModel.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/02/26.
//

import Foundation
import AuthenticationServices
import Alamofire

class SignInViewModel: ObservableObject {
    
    enum OutputEvent {
        case checkNewMember, checkMember, errorNetwork, errorAppleToken, errorServer
    }
    
    @Published var outputEvent: OutputEvent? = nil
    private var appleSignInDelegates: SignInWithAppleDelegate! = nil
    
    
    
    func appleLogin() {
        appleSignInDelegates = SignInWithAppleDelegate(onSignedIn: requestLogin)
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = appleSignInDelegates
        authorizationController.performRequests()
    }
    
    func requestLogin(token: String) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-AUTH-TOKEN": token
        ]
        
        NetworkingClinet.shared.request(serviceURL: .requestPostLogin, httpMethod: .post,  parameter: RequestLoginMessage(token: token), headers: headers, type: ResponseLoginMessage.self) { responseData, error in
            if let error = error {
                
            } else {
                if let responseData = responseData, let responseMessage = responseData.1, let code = responseMessage.code {
                    if let debugMessage = responseData.0 {
                        print(debugMessage)
                    }

                    if(code == 1000) {
                        // 기존 회원
                        // 테스트를 위함
                        self.outputEvent = .checkMember
                        if let result = responseMessage.result {
                            if let accessToken = result.accessToken {
                                AppDataService.shared.setData(appData: .accessToken, value: accessToken)
                            }
                            
                            if let refreshToken = result.refreshToken {
                                AppDataService.shared.setData(appData: .refreshToken, value: refreshToken)
                            }
                        }
                        //self.outputEvent = .checkMember
                    } else if(code == 3005) {
                        // 신규 회원
                        self.outputEvent = .checkNewMember
                    } else if(code == 3002) {
                        // 애플 통신 실패
                        self.outputEvent = .errorNetwork
                    } else if(code == 3005) {
                        // 가입되지 않은 유저
                        self.outputEvent = .errorAppleToken
                    } else if(code == 500) {
                        // 서버 내부 오류
                        self.outputEvent = .errorServer
                    }
                }
            }
        }
    }
}


