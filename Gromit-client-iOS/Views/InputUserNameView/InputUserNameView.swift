//
//  TempInputUserNameView.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/02/26.
//

import SwiftUI
import Combine

struct InputUserNameView: View {
    enum Field {
        case userNickname
      }
    let maxLength = Int(8)
    
    @State private var userNickname = ""    // State
    @FocusState private var focusField: Field?
    @StateObject var inputUserNameViewModel = InputUserNameViewModel()
    //@State private var showingAlert = false
    //@State private var alertTitle = ""
    //@State private var alertMessage = ""
    //@State private var showSignInView = false
    @AppStorage("rootPage") var rootPage: RootPage = .signInView
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
            VStack {
                Text("사용할 닉네임을 입력해주세요.")
                    .fontWeight(.bold)
                TextField("한글, 숫자, 영어 8자 이하..", text: $userNickname)
//                    .focused($focusField, equals: .userNickname)
                    .frame(width: 279, height: 40, alignment: .center)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 111, trailing: 20))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onReceive(Just($userNickname), perform: { _ in
                                    if maxLength < userNickname.count {
                                        userNickname = String(userNickname.prefix(maxLength))
                                    }
                                })
                // 특수문자 필터 처리 필요
                    .textCase(.none)
                    .truncationMode(.middle)
                    .lineLimit(1)
                    .tracking(1.5)
                    .allowsTightening(true)
                    .keyboardType(.namePhonePad)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    //.modifier(UserNameFieldClearButton(text: $userNickname))    // 흠..
                Button("입력") {
                    if userNickname.isEmpty {
                        //self.alertTitle = "닉네임을 입력해주세요."
                        //self.alertMessage = ""
                        coordinator.present(fullScreenCover: .checkGitUserPopup)
//                        coordinator.openPopup(popup: .emptyUserName, okAction: {
//                            coordinator.closePopup()
//                        })
                    } else {
                        // 동기 작업 필요? 1. 아무것도 입력하지 않고 2. 확인을 누른뒤 3. 닉네임 입력하고 4. 확인 누르면 5. 첫번째 알림창에서 메시지가 안뜨는 오류
                        hideKeyboard()
                        //print("Complete Input and sign in...")
                        //print("request user name: \(userNickname)")
                        //inputUserNameViewModel.inputUserName(rUserName: userNickname)
                        //self.alertTitle = inputUserNameViewModel.responseMessage
                        //self.alertMessage = inputUserNameViewModel.responseUserName
                        coordinator.startLoading()
                        inputUserNameViewModel.requestCheckUserNickName(userNickname)
                    }
                    //print("userName: \(self.alertMessage) / alertTitle: \(self.alertTitle)")
                    //self.showingAlert.toggle()
                }
//                .alert(isPresented: $showingAlert) {
//                    Alert(
//                        title: Text("\(alertTitle)"),
//                        message: Text("\(alertMessage)"),
//                        dismissButton: .default(Text("확인")) {
//                            // 아래 코드 작동 안됨...
//                            UserDefaults.standard.set(userNickname, forKey: "nickname")
//                            guard let nickname = UserDefaults.standard.string(forKey: "nickname") else { return }
//                            guard let githubName = UserDefaults.standard.string(forKey: "githubName") else { return }
//                            guard let email = UserDefaults.standard.string(forKey: "email") else { return }
//                            guard let provider = UserDefaults.standard.string(forKey: "provider") else { return }
//                            print("userName: \(nickname) / githubName: \(githubName) / email: \(email) / provider: \(provider)")
//                            inputUserNameViewModel.postSignUp(rNickname: nickname, rgithubName: githubName, rEmail: email, rProvider: provider)
//                        }
//                    )
//                }
                .buttonStyle(InputButtonStyle(width: 250, height: 50))
                //.frame(maxWidth: .infinity, maxHeight: .infinity) // <-
                .onTapGesture { // <-
                    hideKeyboard()
                }
//              킴쿡 수정 로그인 기능 추가
//                Button("(임시)시작 화면 되돌아가기") {
//                    showSignInView.toggle()
//                }
//                .fullScreenCover(isPresented: $showSignInView) {
//                    SignInView()
//                }
            }.onReceive(inputUserNameViewModel.$outputEvent) { event in
                if let event = event {
                    receiveViewModelEvent(event)
                }
            }
    }
}

extension InputUserNameView {
    private func receiveViewModelEvent(_ event: InputUserNameViewModel.OutputEvent) {
        print(event)
        switch event {
        case .requestError:
            coordinator.stopLoading()
            //coordinator.present(alertPopup: .requesetServerError)
            coordinator.openPopup(popup: .requestServerError, okAction: {
                coordinator.closePopup()
            })
        case .isExistGromitUser:
            // 팝업을 통해 해당 닉네임은 중복 된 것임을 알림
            coordinator.stopLoading()
            //coordinator.present(alertPopup: .isExistGromitUser)
            coordinator.openPopup(popup: .isExistGromitUser
            , okAction: {
                coordinator.closePopup()
            })
        case .isNotExistGromitUser:
            // 팝업을 통해 정말 해당 닉네임으로 할지 물어보기
            coordinator.stopLoading()
            coordinator.openPopup(popup: .isNotExistGromitUser, okAction: {
                coordinator.closePopup()
                inputUserNameViewModel.requestSignUpUser(userNickname)
            }, cancleAction: {
                coordinator.closePopup()
            })
           
        case .createGromitUser:
            coordinator.stopLoading()
//            self.rootPage = .gromitMainView
//            coordinator.push(page: .gromitMainView)
            LoginService.shared.saveLoginHistory()
            coordinator.popToRoot()
            coordinator.rootPage = .homeView
        }
    }
}

struct InputUserNameView_Previews: PreviewProvider {
    static var previews: some View {
        InputUserNameView()
    }
}
