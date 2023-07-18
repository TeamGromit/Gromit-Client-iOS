//
//  SettingView.swift
//  Gromit-client-iOS
//
//  Created by 김진영 on 2023/06/29.
//

import SwiftUI

struct SettingView: View {
    @State private var toggling = false
    @State private var showingToggle = false
    @State private var showingAlert = false
    @State private var showingAlert2 = false
    @State private var showingAlert3 = false
    @State private var showSignInView = false
    @State var date = Date()
    
//    @StateObject private var settingsViewModel = SettingsViewModel()
    @StateObject var settingViewModel = SettingViewModel()
    @EnvironmentObject private var coordinator: Coordinator
    
    init() {
        print("SettingView init!")
    }
    
    var body: some View {
        List {
            Toggle(isOn: $showingToggle) {
                Text("알람")
            }
            if showingToggle {
                Button(action: {}) {
                    DatePicker(
                        "알람 시간 설정",
                        selection: $date,
                        displayedComponents: [.hourAndMinute]
                    )
                }
            }
            
            Link("이용 약관", destination: URL(string: "https://www.notion.so/Gromit-67f86ba5f9fc47abb6b7061016e37395?pvs=4")!)
                .foregroundColor(.black)
            
            HStack {
                Text("버전 정보")
                Spacer()
                Text("ver. 0.1.0").foregroundColor(.gray)
            }
            
            Button("닉네임 변경") {
                //showSignInView.toggle()
                coordinator.push(.settingView, page: .changeGromitUserNameView)
            }
            .fullScreenCover(isPresented: $showSignInView) {
                ChangeNameView()
            }
            .foregroundColor(.black)
            
            Button("로그아웃") {
                self.showingAlert.toggle()
            }
            .foregroundColor(.black)
            .alert(isPresented: $showingAlert) {
                let firstButton = Alert.Button.default(Text("OK")) {
                    print("primary button pressed")
                    settingViewModel.logOut()
                    coordinator.popToRoot()
                    coordinator.rootPage = .signInView
                }
                let secondButton = Alert.Button.cancel(Text("Cancel")) {
                    print("secondary button pressed")
                }
                return Alert(title: Text("로그아웃 하시겠습니까?"),
                             primaryButton: firstButton, secondaryButton: secondButton)
            }
            
            Button("서비스 탈퇴") {
                self.showingAlert2.toggle()
            }
            .foregroundColor(.black)
            .alert(isPresented: $showingAlert2) {
                let firstButton = Alert.Button.default(Text("돌아가기")) {
                    print("primary button pressed")
                }
                let secondButton = Alert.Button.cancel(Text("탈퇴하기")) {
                    print("secondary button pressed")
                    settingViewModel.signOut()
                }
                return Alert(title: Text("탈퇴를 진행할 경우\n모든 정보가 삭제됩니다.\n계속 진행하시겠습니까?"),
                             primaryButton: firstButton, secondaryButton: secondButton)
            }
        }.onReceive(settingViewModel.$outputEvent) { event in
            if let event = event {
                receiveViewModelEvent(event)
            }
        }
    }
}

extension SettingView {
    private func receiveViewModelEvent(_ event: SettingViewModel.OutputEvent) {
        switch event {
        case .reqeustError:
            coordinator.stopLoading()
            coordinator.openPopup(popup: .requestServerError, okAction: {
                coordinator.closePopup()
            })
        case .signOut:
            coordinator.stopLoading()
            LoginService.shared.initLoginHistory()
            coordinator.popToRoot()
            coordinator.rootPage = .signInView
        case .logOut:
            coordinator.stopLoading()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
