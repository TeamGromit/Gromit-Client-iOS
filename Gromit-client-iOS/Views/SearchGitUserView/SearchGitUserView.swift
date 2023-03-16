//
//  TempSearchGitUserView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/31.
//

import SwiftUI

struct SearchGitUserView: View {
    enum Field {
        case userName
    }
   // @AppStorage("githubName") var githubName: String = ""

    
    @State private var userName = ""
    @FocusState private var focusField: Field?
    @State private var showingAlert = false
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject var searchGitUserViewModel = SearchGitUserViewModel()
    
    @State var alertTitle = ""
    // 데모데이 영상 촬영용 임시 변수
    @State private var showInputUserNameView = false
    
    var body: some View {
        VStack {
            Text("깃허브 유저 네임을 입력해주세요")
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
            
            Button("입력") {
                if userName.isEmpty {
                    focusField = .userName
                    //coordinator.present(alertPopup: .emptyUserName)
                    coordinator.openPopup(popup: .emptyUserName, okAction: coordinator.closePopup)
                } else {
                    print("Complete Input and sign in...")
//                    킴쿡 수정 : 로그인 기능 추가
//                    searchGitUserViewModel.getGitUserName(rGitName: userName)
//                    if (searchGitUserViewModel.responseGitName == "") {
//                        self.alertTitle = "해당 유저를 찾을 수 없습니다."
//                    } else {
//                        self.alertTitle = "해당 유저가 맞습니까?"
//                    }
//                    self.showingAlert.toggle()
                    coordinator.startLoading()
                    searchGitUserViewModel.requestCheckGitUserName(userName)
                    
                }
            }
//            .alert(isPresented: $showingAlert) {
//                Alert(
//                    title: Text(self.alertTitle),
//                    message: Text("\(searchGitUserViewModel.responseGitName)"),
//                    primaryButton: .default(Text("네"), action: {
//                        UserDefaults.standard.set(userName, forKey: "githubName")
//                    }),
//                    secondaryButton: .cancel(Text("아니요")))
//            }
            .buttonStyle(InputButtonStyle(width: 250, height: 50))

            //
//            Button("(임시)그로밋 닉네임 페이지 이동") {
//                showInputUserNameView.toggle()
//            }
//            .fullScreenCover(isPresented: $showInputUserNameView) {
//                InputUserNameView()
//            }
        }
        .navigationBarHidden(true)
        .onReceive(searchGitUserViewModel.$outputEvent) { event in
            if let event = event {
                receiveViewModelEvent(event)
            }
        }
    }
                    
    
}

extension SearchGitUserView {
    private func receiveViewModelEvent(_ event: SearchGitUserViewModel.OutputEvent) {
        switch event {
        case .isExistGitUser:
            coordinator.stopLoading()
            coordinator.openPopup(popup: .isCheckGitUser
            , okAction: {
                searchGitUserViewModel.confirmGitUser(isConfirm: true)
                coordinator.closePopup()
            }, cancleAction: {
                searchGitUserViewModel.confirmGitUser(isConfirm: false)
                coordinator.closePopup()
            })
            
//            coordinator.present(alertPopup: .isExistGitUser) {
//                searchGitUserViewModel.confirmGitUser()
//            }
        case .isNotExistGitUser:
            coordinator.stopLoading()
            coordinator.openPopup(popup: .isNotExistGitUser, okAction: {
                coordinator.closePopup()
            })
            //coordinator.present(alertPopup: .isNotExistGitUser)
        case .requestError:
            coordinator.stopLoading()
            coordinator.openPopup(popup: .requestServerError, okAction: {
                coordinator.closePopup()
            })
            //coordinator.present(alertPopup: .requesetServerError)
        case .nextViewPage:
            //coordinator.push(page: .inputUserNameView)
            coordinator.push(.signInView, page: .inputUserNameView)
        }
    }
}

struct TempSearchGitUserView_Previews: PreviewProvider {
    static var previews: some View {
        SearchGitUserView()
    }
}
