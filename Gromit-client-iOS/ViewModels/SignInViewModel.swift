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
        case checkNewMember, checkMember, errorNetwork, errorAppleToken, errorServer, failAppleLogin, timeOutNetworking
    }
    
    @Published var outputEvent: OutputEvent? = nil
    private var appleSignInDelegates: SignInWithAppleDelegate! = nil
    
    
    
    func appleLogin() {
        appleSignInDelegates = SignInWithAppleDelegate(onSignedIn: requestLogin, onFail: appleLoginFail)
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = appleSignInDelegates
        authorizationController.performRequests()
    }
    
    func appleLoginFail() {
        self.outputEvent = .failAppleLogin
    }
    
    func requestLogin(appleToken: String, email: String) {
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "X-AUTH-TOKEN": appleToken
//        ]
        
        NetworkingClinet.shared.request(serviceURL: .requestPostLogin, httpMethod: .post,  parameter: RequestLoginMessage(token: appleToken), type: ResponseLoginMessage.self) { responseData, error in
            if let error = error {
                if error._code == 13 {
                    print("Request timeout!")
                    self.outputEvent = .timeOutNetworking

                } else {
                    print("Other error!")

                }
//                }
            } else {
                if let responseData = responseData, let responseMessage = responseData.1, let code = responseMessage.code {
                    if(code == 1000) {
                        if let result = responseMessage.result {
                            guard let accessToken = result.accessToken else {
                                return
                            }
                            guard let refreshToken = result.refreshToken else {
                                return
                            }
                            LoginService.shared.setLoginInfo(email: email, accessToken: accessToken, refreshToken: refreshToken)
                            LoginService.shared.saveLoginHistory()
                            self.outputEvent = .checkMember
                        }
                    } else if(code == 3005) {
                        // 신규 회원
                        LoginService.shared.setLoginInfo(email: email)

                        self.outputEvent = .checkNewMember
                        //LoginService.shared.setLoginInfo(email: email, accessToken: accessToken, refreshToken: refreshToken)

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


