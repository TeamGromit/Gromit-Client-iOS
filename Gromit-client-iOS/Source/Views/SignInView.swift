//
//  SignInView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/21.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        VStack {
            Text("SignIn")
            
            // logo
            
            // apple login
            
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

// -------------------------------------------------------------------


//class ViewController: UIViewController {
//
//}
//
//func setupProviderLoginView() {
//    let appleButton = ASAuthorizationAppleIDButton()
//    appleButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
//    self.SignInView.addSubview(appleButton)
//
//    appleButton.translatesAutoresizingMaskIntoConstraints = false
//    appleButton.leadingAnchor.constraint(equalTo: SignInView.leadingAnchor).isActive = true
//    appleButton.trailingAnchor.constraint(equalTo: SignInView.trailingAnchor).isActive = true
//    appleButton.topAnchor.constraint(equalTo: SignInView.topAnchor).isActive = true
//    appleButton.bottomAnchor.constraint(equalTo: SignInView.bottomAnchor).isActive = true
//}
//
//@objc
//func handleAuthorizationAppleIDButtonPress() {
//    let appleIDProvider = ASAuthorizationAppleIDProvider()
//    let request = appleIDProvider.createRequest()
//    request.requestedScopes = [.fullName, .email]
//
//    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//}
//
//extension SignInView: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return self.view.window!
//    }
//}
