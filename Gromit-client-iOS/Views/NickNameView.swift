import SwiftUI
import Combine

struct NickNameView: View {
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
            Text("변경할 닉네임을 입력해주세요.")
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
            Button("확인") {
                if userNickname.isEmpty {
                    self.alertTitle = "닉네임을 입력해주세요."
                    self.alertMessage = ""
                } else {
                    
                    hideKeyboard()
                    print("Complete Input and sign in...")
                    print("request user name: \(userNickname)")
                    inputUserNameViewModel.inputUserName(rUserName: userNickname)
                    self.alertTitle = inputUserNameViewModel.responseMessage
                    self.alertMessage = inputUserNameViewModel.responseUserName
                }
                print("userName: \(self.alertMessage) / alertTitle: \(self.alertTitle)")
                self.showingAlert.toggle()
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("\(alertTitle)"),
                    message: Text("\(alertMessage)"),
                    dismissButton: .default(Text("변경되었습니다")) {
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
            .buttonStyle(InputButtonStyle())
            //.frame(maxWidth: .infinity, maxHeight: .infinity) // <-
            .onTapGesture { // <-
                hideKeyboard()
            }
            
        }
    }
    
    struct NickNameView_Previews: PreviewProvider {
        static var previews: some View {
            NickNameView()
        }
    }
    //
    //#if canImport(UIKit)
    //extension View {
    //    func hideKeyboard() {
    //        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    //    }
    //}
    //#endif
    //
    //// Clear Button...
    //struct UserNameFieldClearButton: ViewModifier {
    //    @Binding var text: String
    //
    //    func body(content: Content) -> some View {
    //        ZStack(alignment: .trailing) {
    //            content
    //            if !text.isEmpty {
    //                Button(
    //                    action: {
    //                        self.text = ""
    //                    })
    //                {
    //                    Image(systemName: "delete_ui")
    //                        .foregroundColor(Color(UIColor.opaqueSeparator))
    //                }
    //                .padding(.trailing, 8)
    //            }
    //        }
    //    }
    //}
    //
    //struct InputButtonStyle: ButtonStyle {
    //
    //    var backgroundColor = Color(red: 255 / 255, green: 247 / 255, blue: 178 / 255)
    //    var cornerRadius: CGFloat = 10
    //
    //    func makeBody(configuration: Configuration) -> some View {
    //        configuration.label
    //            .foregroundColor(.black)
    //            .padding(EdgeInsets(top: 16, leading: 123, bottom: 16, trailing: 123))
    //            .background(RoundedRectangle(cornerRadius: cornerRadius).fill(backgroundColor))
    //            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
    //            .shadow(radius: 2.5)
    //            .fontWeight(.bold)
    //    }
    //}
}
