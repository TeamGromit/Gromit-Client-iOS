//
//  SignInView.swift
//  Gromit-iOS
//
//  Created by julia on 2023/01/13.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @State var appleSignInDelegates: SignInWithAppleDelegate! = nil
    @State private var showSearchGitUser = false
    
    var body: some View {
        
        ZStack {
            Color("yellow500").ignoresSafeArea()
            
            VStack(spacing: 173) { // 99
                // logo
                Text("Gromit Logo")
                    .fontWeight(.bold)
                    .background (
                        Circle()
                            .fill(Color("green500"))
                            .frame(width: 186, height: 186)
                    )
                
                // apple login
                SignInWithAppleButtonView()
                    .frame(width: 280, height: 60, alignment: .center)
                    .cornerRadius(30)
                    .onTapGesture {
                        self.showAppleLogin()
                    }
            }
        }
    }
    
    private func showAppleLogin() {
        appleSignInDelegates = SignInWithAppleDelegate {
            print("로그인 성공? : \($0)")
        }
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = appleSignInDelegates
        authorizationController.performRequests()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

struct SignInWithAppleButtonView: UIViewRepresentable {
    typealias UIViewType = UIView
        
    func makeUIView(context: Context) -> UIView {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .white)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        //
    }
}

class SignInWithAppleDelegate: NSObject {
    private let signInSucceeded: (Bool) -> Void
    
    init(onSignedIn: @escaping (Bool) -> Void) {
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
            } else {
                print("========================== 로그인 했었음")
                displayLog(credential: appleIdCredential)
//                signInWithExistingAccount(credential: appleIdCredential)
            }
            signInSucceeded(true)
        default :
            break
        }
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
