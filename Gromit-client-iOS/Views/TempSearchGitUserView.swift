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
    @ObservedObject var searchGitUserViewModel = SearchGitUserViewModel()
    @State var alertTitle = ""
    // 데모데이 영상 촬영용 임시 변수
    @State private var showInputUserNameView = false
    
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
            
            Button("입력") {
                if userName.isEmpty {
                    focusField = .userName
                } else {
                    print("Complete Input and sign in...")
                    searchGitUserViewModel.getGitUserName(rGitName: userName)
                    if (searchGitUserViewModel.responseGitName == "") {
                        self.alertTitle = "해당 유저를 찾을 수 없습니다."
                    } else {
                        self.alertTitle = "해당 유저가 맞습니까?"
                    }
                    self.showingAlert.toggle()
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(self.alertTitle),
                    message: Text("\(searchGitUserViewModel.responseGitName)"),
                    primaryButton: .default(Text("네"), action: {
                        
                    }),
                    secondaryButton: .cancel(Text("아니요")))
            }
            
            Button("그로밋 닉네임 페이지 이동") {
                showInputUserNameView.toggle()
            }
            .fullScreenCover(isPresented: $showInputUserNameView) {
                InputUserNameView()
            }
        }
    }
}

struct TempSearchGitUserView_Previews: PreviewProvider {
    static var previews: some View {
        TempSearchGitUserView()
    }
}
