//
//  InputUserNicknameView.swift
//  Gromit-client-iOS
//
//  Created by 김진영 on 2023/01/28.
//

import SwiftUI
import Combine

struct InputUserNameView_Backup: View {
    enum Field {
        case userNickname
      }
    let maxLength = Int(8)

    @State private var userNickname = ""    // State
    @FocusState private var focusField: Field?
    @ObservedObject var inputUserNameViewModel = InputUserNameViewModel()
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showSignInView = false

    var body: some View {
            VStack {
                Text("사용할 닉네임을 입력해주세요.")
                    .fontWeight(.bold)
                TextField("User Nickname", text: $userNickname)
                    .focused($focusField, equals: .userNickname)
                    .frame(width: 279, height: 40, alignment: .center)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 111, trailing: 20))
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
                        self.alertTitle = "닉네임을 입력해주세요."
                        self.alertMessage = ""
                    } else {
                        // 동기 작업 필요? 1. 아무것도 입력하지 않고 2. 확인을 누른뒤 3. 닉네임 입력하고 4. 확인 누르면 5. 첫번째 알림창에서 메시지가 안뜨는 오류
                        hideKeyboard()
                        print("Complete Input and sign in...")
                        print("request user name: \(userNickname)")
                        
                        //inputUserNameViewModel.inputUserName(rUserName: userNickname)
                        //self.alertTitle = inputUserNameViewModel.responseMessage
                        //self.alertMessage = inputUserNameViewModel.responseUserName
                        inputUserNameViewModel.requestCheckUserNickName(userNickname)
                    }
                    print("userName: \(self.alertMessage) / alertTitle: \(self.alertTitle)")
                    self.showingAlert.toggle()
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
                .buttonStyle(InputButtonStyle())
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
            }
    }
}

struct InputUserNameView_Backup_Previews: PreviewProvider {
    static var previews: some View {
        InputUserNameView_Backup()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

// Clear Button...
struct UserNameFieldClearButton: ViewModifier {
    @Binding var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button(
                    action: {
                        self.text = ""
                    })
                {
                    Image(systemName: "delete_ui")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 8)
            }
        }
        .navigationBarHidden(true)
    }
}

struct InputButtonStyle: ButtonStyle {

    var backgroundColor = Color(red: 255 / 255, green: 247 / 255, blue: 178 / 255)
    var cornerRadius: CGFloat = 10

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .padding(EdgeInsets(top: 16, leading: 123, bottom: 16, trailing: 123))
            .background(RoundedRectangle(cornerRadius: cornerRadius).fill(backgroundColor))
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .shadow(radius: 2.5)
            .fontWeight(.bold)
    }
}
