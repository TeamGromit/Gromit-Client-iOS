//
//  SignInWithAppleDelegate.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/02/26.
//

import Foundation
import AuthenticationServices
import SwiftUI

class SignInWithAppleDelegate: NSObject {
//    @AppStorage("email") var email: String = ""
//    @AppStorage("provider") var provider: String = ""

    
    private let signInSucceeded: (String) -> Void
    
    init(onSignedIn: @escaping (String) -> Void) {
        signInSucceeded = onSignedIn
    }
}

// Delegate 설정
extension SignInWithAppleDelegate: ASAuthorizationControllerDelegate {
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            // Apple ID
            
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            if let _ = appleIdCredential.email, let _ = appleIdCredential.fullName {
                print("========================== 첫 로그인")
                displayLog(credential: appleIdCredential)
                //                registerNewAccount(credential: appleIdCredential) //appleIdCredential에서 정보가 들어있으면 register, 아니면 sign In
                
                // 회원가입 완료 후 로그인 유지를 위해 email을 UserDefaults에 저장. UserDefaults에는 email, provider, nickname, githubName이 저장될 것
                guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
                
                if let email = credential.email {
                    print("AppStorage Save Email")
                
                    AppDataService.shared.setData(appData: .email, value: email)
                    AppDataService.shared.setData(appData: .provider, value: "APPLE")
         
                }
              
                
            } else {
                print("========================== 로그인 했었음")
                displayLog(credential: appleIdCredential)
                guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
                
                if let tokenString = String(data: credential.identityToken ?? Data(), encoding: .utf8) {
                    let email = decode(tokenString: tokenString)["email"] as? String ?? ""
                    
                    AppDataService.shared.setData(appData: .email, value: email)
                    AppDataService.shared.setData(appData: .provider, value: "APPLE")
                    
                }
            }
            if let token = getToken(credential: appleIdCredential) {
                print(token)
                signInSucceeded(token)
            }
        default :
            break
        }
    }
    
    // AppleID 로그인한 이력이 있는 경우 Decode 하여 email을 가져와야한다.
    private func decode(tokenString: String) -> [String: Any] {
        
        func base64UrlDecode(_ value: String) -> Data? {
            var base64 = value
                .replacingOccurrences(of: "-", with: "+")
                .replacingOccurrences(of: "_", with: "/")

            let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
            let requiredLength = 4 * ceil(length / 4.0)
            let paddingLength = requiredLength - length
            if paddingLength > 0 {
                let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
                base64 = base64 + padding
            }
            return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
        }

        func decodeJWTPart(_ value: String) -> [String: Any]? {
            guard let bodyData = base64UrlDecode(value),
                  let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
                return nil
            }

            return payload
        }
        
        let segments = tokenString.components(separatedBy: ".")
        return decodeJWTPart(segments[1]) ?? [:]
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
    // 계정 정보 가져오기
    private func displayLog(credential: ASAuthorizationAppleIDCredential) {
        let userIdentifier = credential.user
        let fullName = credential.fullName
        let email = credential.email
        let idToken = credential.identityToken!
        let tokeStr = String(data: idToken, encoding: .utf8)
        
        print("User ID : \(userIdentifier)")
        print("User Email : \(email ?? "")")
        print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
        print("Identity Token : \(String(describing: tokeStr))")
        print("Authorization Code : \(credential.authorizationCode!)")
        print("Credential : \(credential)")
    }
    
    private func getToken(credential: ASAuthorizationAppleIDCredential) -> String? {
        if let idToken = credential.identityToken {
            
            let tokenString = String(data: idToken, encoding: .utf8)
            //갑자기 되다가 안됨 describing Optional 이 그대로 딸려옴
            //return String(describing: tokenString)
            
            return tokenString
        }
        
        return nil
    }
    
    // 작업중
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: "00000.abcabcabcabc.0000" /* 로그인에 사용한 User Identifier */) { (credentialState, error) in
            switch credentialState {
            case .authorized:       // 이미 증명이 된 경우
                // The Apple ID credential is valid.
                print("해당 ID는 연동되어 있습니다.")
            case .revoked:      // 증명을 취소했을 때
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                print("해당 ID는 연동되어 있지 않습니다.")
            case .notFound:     // 증명이 존재하지 않을 경우
                // The Apple ID credential is either was not found, so show the sign-in UI.
                print("해당 ID를 찾을 수 없습니다.")
                DispatchQueue.main.async {
                    // self.window?.rootViewController?.showLoginViewController()
                }
            default:
                break
            }
        }
        return true
    }
    
    //    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential) {
    //        let userData = UserData(email: credential.email!, name: credential.fullName!, identifier: credential.user)
    //
    //        let keychain = UserDataKeychain()
    //        do {
    //            try keychain.store(userData)
    //        } catch {
    //            self.signInSucceeded(false)
    //        }
    //
    //        do {
    //            let success = try WebApi.Register (
    //        }
    //    }
}

extension SignInWithAppleDelegate:ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.last!
    }
}
