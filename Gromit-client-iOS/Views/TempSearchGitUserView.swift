//
//  TempSearchGitUserView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/31.
//

import SwiftUI

struct TempSearchGitUserView: View {
    enum Field {
        case userName
    }
    
    @State private var userName = ""
    @FocusState private var focusField: Field?
    @State private var showingAlert = false
    @StateObject private var network = UserService.shared
    
    var body: some View {
        VStack {
            Text("깃허브 유저 네임을 입력해주세요")
            
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
                .modifier(UserNameFieldClearButton(text: $userName))
            
            Button("입력") {
                if userName.isEmpty {
                    focusField = .userName
                } else {
                    hideKeyboard()
                    print("Complete Input and sign in...")
                    self.showingAlert.toggle()
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("해당 유저가 맞습니까?"),
//                    message: Text("\(userName)"),
                    message: Text("\(network.gitName)").onAppear {
                        network.getGitUser(name: userName)
                        print("View-userName: \(userName)")
                    } as? Text,
                    primaryButton: .default(Text("네"), action: {
                        
                    }),
                    secondaryButton: .cancel(Text("아니요")))
            }
            .buttonStyle(InputButtonStyle())
            .onTapGesture { // <-
                hideKeyboard()
            }
        }
//        .onAppear {
//            network.getGitUser(name: userName)
//        }
    }
}

struct TempSearchGitUserView_Previews: PreviewProvider {
    static var previews: some View {
        TempSearchGitUserView()
    }
}
