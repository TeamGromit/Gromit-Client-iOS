//
//  InputUserNicknameView.swift
//  Gromit-client-iOS
//
//  Created by 김진영 on 2023/01/28.
//

import SwiftUI
import Combine

struct InputUserNicknameView: View {
    
    enum Field {
        case userNickname
      }
    let maxLength = Int(8)
    
    @State private var userNickname = ""    // State
    @FocusState private var focusField: Field?
    
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
                        focusField = .userNickname
                    } else {
                        hideKeyboard()
                        print("Complete Input and sign in...")
                    }
                }
                .buttonStyle(InputButtonStyle())
                //.frame(maxWidth: .infinity, maxHeight: .infinity) // <-
                .onTapGesture { // <-
                    hideKeyboard()
                }
            }
    }
}

struct SearchGitUserView_Previews: PreviewProvider {
    static var previews: some View {
        InputUserNicknameView()
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
