//
//  GitUserNameView.swift
//  Gromit-client-iOS
//
//  Created by julia on 2023/01/23.
//

import SwiftUI
import PopupView

struct SearchGitUserView: View {
    enum Field {
        case userName
    }
    
//    @State var shouldShowPopup : Bool = false
    @State private var userName = ""    // State
    @FocusState private var focusField: Field?
    
//    func createPopup() -> some View {
//        VStack(spacing: 10) {
//            Image(systemName: "refresh")
//                .resizable()
//                .aspectRatio(contentMode: ContentMode.fit)
//                .frame(width: 81, height: 81)
//
//            Text("해당 유저가 맞습니까?")
//                .fontWeight(.bold)
//
//            Spacer().frame(height: 50)
//
//            Button(action: {
//                self.shouldShowPopup = false
//            }) {
//                Text("네")
//                    .font(.system(size: 14))
//                    .foregroundColor(.black)
//                    .fontWeight(.bold)
//            }
//            .frame(width: 100, height: 40)
//            .background(Color.white)
//            .cornerRadius(20.0)
//        }
//    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("GitHub User 이름을 입력해주세요.")
                    .fontWeight(.bold)
                
                TextField("User Name", text: $userName)
                    .focused($focusField, equals: .userName)
                    .frame(width: 279, height: 40, alignment: .center)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 111, trailing: 20))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textCase(.none)
                    .truncationMode(.middle)
                    .lineLimit(1)
                    .tracking(1.5)
                    .allowsTightening(true)
                    .keyboardType(.namePhonePad)
                    .onSubmit {
                        print("user did tap return , \(userName)")
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .modifier(UserNameFieldClearButton(text: $userName))    // 흠..
                
                Button("입력") {
                    if userName.isEmpty {
                        focusField = .userName
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
}

struct SearchGitUserView_Previews: PreviewProvider {
    static var previews: some View {
        SearchGitUserView()
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
