//
//  SignInView.swift
//  Gromit-iOS
//
//  Created by julia on 2023/01/13.
//

import SwiftUI
import AuthenticationServices
import Combine

struct SignInView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var signInViewModel = SignInViewModel()
    
    @State private var showSearchGitUser = false
    //@AppStorage("rootPage") var rootPage: RootPage = .signInView

    // 데모데이 영상 촬영용 임시 변수
    @State private var showTempSearchGitUser = false
    @State private var showGromitMainView = false
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        navigationBarHidden(false)
    }
    var body: some View {
        ZStack {
//            Color(red: 100, green: 100, blue: 100).ignoresSafeArea()  // 화이트 배경색 적용
            Color("yellow500").ignoresSafeArea()
            
            VStack(spacing: 45) {
                // Origin logo
                Image("gromit_new_appIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(30)
                    .padding(.all, 40)
                
                // apple login
                SignInWithAppleButtonView()
                    .frame(width: 280, height: 60, alignment: .center)
                    .cornerRadius(20)
                    .onTapGesture {
                        self.showAppleLogin()
                    }
            }.onReceive(signInViewModel.$outputEvent) { event in
                if let event = event {
                    receiveViewModelEvent(event)
                }
            }
        }
    }
    
    private func receiveViewModelEvent(_ event: SignInViewModel.OutputEvent) {
        switch event {
        case .checkNewMember:
            //coordinator.push(page: .gitHubNameCheckView)
            coordinator.push(.signInView, page: .gitHubNameCheckView)
        case .checkMember:
            //rootPage = .gromitMainView
            coordinator.rootPage = .homeView
            //coordinator.push(page: .gromitMainView)
            
        case .errorNetwork, .errorAppleToken, .errorServer:
            coordinator.openPopup(popup: .signInError, okAction: {
                coordinator.closePopup()
            })
            
        case  .failAppleLogin:
            coordinator.openPopup(popup: .failAppleSignIn, okAction: {
                coordinator.closePopup()
            })
        case .timeOutNetworking:
            coordinator.openPopup(popup: .timeOutNetwork, okAction: {
                coordinator.closePopup()
            })
        }
    }
    
    private func showAppleLogin() {
        signInViewModel.appleLogin()
        
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
        
    }
}
