//
//  ChangeNameView.swift
//  Gromit-client-iOS
//
//  Created by 이현진 on 2023/03/03.
//

import SwiftUI
import Combine

struct ChangeNameView: View {
    enum Field {
        case userNickname
      }
    let maxLength = Int(8)
    
    @State private var userNickname = ""
    @FocusState private var focusField: Field?
    @ObservedObject var inputUserNameViewModel = InputUserNameViewModel()
    @StateObject var changeNameViewModel = ChangeNameViewModel()

    
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showSignInView = false
    
    @EnvironmentObject private var coordinator: Coordinator

    
    var body: some View {
            VStack {
                NavigationBarView(isActiveLeftButton: true, isActiveRightButton: false, title: "닉네임 변경", leftButtonTitle: "뒤로가기",leftButtonTapped: {
                    coordinator.pop(.settingView)
                })
                
                Spacer()
               
                Text("변경할 닉네임을 입력해주세요.")
                    .fontWeight(.bold)
                TextField("User Nickname", text: $userNickname)
                    .focused($focusField, equals: .userNickname)
                    .frame(height: 40, alignment: .center)
                    .padding(EdgeInsets(top: 20, leading: 40, bottom: 111, trailing: 40))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onReceive(Just($userNickname), perform: { _ in
                                    if maxLength < userNickname.count {
                                        userNickname = String(userNickname.prefix(maxLength))
                                    }
                                })
                    .textCase(.none)
                    .truncationMode(.middle)
                    .lineLimit(1)
                    .tracking(1.5)
                    .allowsTightening(true)
                    .keyboardType(.namePhonePad)
                    .onSubmit {
                        print("user did tap return , \(userNickname)")
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .modifier(UserNameFieldClearButton(text: $userNickname))    // 흠..
                
                Button("입력") {
                    if userNickname.isEmpty {
//                        self.alertTitle = "닉네임을 입력해주세요."
//                        self.alertMessage = ""
                        coordinator.openPopup(popup: .emptyUserName, okAction: coordinator.closePopup)
                    } else {
                        // 동기 작업 필요? 1. 아무것도 입력하지 않고 2. 확인을 누른뒤 3. 닉네임 입력하고 4. 확인 누르면 5. 첫번째 알림창에서 메시지가 안뜨는 오류
                        
//                        .fullScreenCover(isPresented: $showSignInView) {
//                            SignInView()
//                        }
                        //coordinator.openPopup(popup: .is)
                        hideKeyboard()
                        print("Complete Input and sign in...")
                        print("request user name: \(userNickname)")
//                        inputUserNameViewModel.inputUserName(rUserName: userNickname)
//                        self.alertTitle = inputUserNameViewModel.responseMessage
//                        self.alertMessage = inputUserNameViewModel.responseUserName
                        coordinator.startLoading()
                        changeNameViewModel.requestCheckUserNickName(userNickname)
                    }
//                    print("userName: \(self.alertMessage) / alertTitle: \(self.alertTitle)")
//                    self.showingAlert.toggle()
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("\(alertTitle)"),
                        message: Text("\(alertMessage)"),
                        dismissButton: .default(Text("확인")) {
                            // 아래 코드 작동 안됨...
                            UserDefaults.standard.set(userNickname, forKey: "nickname")
                            guard let nickname = UserDefaults.standard.string(forKey: "nickname") else { return }
                            guard let githubName = UserDefaults.standard.string(forKey: "githubName") else { return }
                            guard let email = UserDefaults.standard.string(forKey: "email") else { return }
                            guard let provider = UserDefaults.standard.string(forKey: "provider") else { return }
                            print("userName: \(nickname) / githubName: \(githubName) / email: \(email) / provider: \(provider)")
                            inputUserNameViewModel.postSignUp(rNickname: nickname, rgithubName: githubName, rEmail: email, rProvider: provider)
                        }
                    )
                }
                .buttonStyle(InputButtonStyle(width: 250, height: 50))
                //.frame(maxWidth: .infinity, maxHeight: .infinity) // <-
                .onTapGesture { // <-
                    hideKeyboard()
                }.onReceive(changeNameViewModel.$outputEvent) { event in
                    if let event = event {
                        receiveViewModelEvent(event)
                    }
                }
                Spacer(minLength: 300)
            }
    }
}

extension ChangeNameView {
    private func receiveViewModelEvent(_ event: ChangeNameViewModel.OutputEvent) {
        print(event)
            coordinator.stopLoading()
            switch event {
            case .isExistGromitUser:
                coordinator.openPopup(popup: .isExistGromitUser
                , okAction: {
                    coordinator.closePopup()
                })
            case .isNotExistGromitUser:
                coordinator.openPopup(popup: .isNotExistGromitUser, okAction: {
                    coordinator.closePopup()
                    coordinator.startLoading()
                    changeNameViewModel.reqeustChangeUserNickName(userNickname)
                    //inputUserNameViewModel.requestSignUpUser(userNickname)
                }, cancleAction: {
                    coordinator.closePopup()
                })
            case .changeGromitNickName:
                coordinator.openPopup(popup: .changeGromitUserName, okAction: {
                    coordinator.closePopup()
                    coordinator.pop(.settingView)
                })
                break
            case .requestError:
                coordinator.openPopup(popup: .requestServerError, okAction: {
                    coordinator.closePopup()
                })
            }
    }
}

struct ChangeNameView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeNameView()
    }
}
