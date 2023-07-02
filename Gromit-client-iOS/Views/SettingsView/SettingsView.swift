
import SwiftUI

struct SettingsView: View {
    @State private var toggling = false
    @State private var showingToggle = false
    @State var date = Date()
    @State private var showingAlert = false
    @State private var showingAlert2 = false
    @State private var showingAlert3 = false
    @State private var showSignInView = false
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var settingsViewModel = SettingsViewModel()

    init() {
        print("SettingView init!")
    }
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $showingToggle) {
                    Text(" 알람")
                }
                    
                if showingToggle {
                    Button(action: {}) {
                        DatePicker(
                            "시간을 설정하세요",
                            selection: $date,
                            displayedComponents: [.hourAndMinute]
                        )
                    }
                }
                Link(" 이용 약관", destination: URL(string: "https://www.notion.so/Gromit-Team-27c8612cb66a446b962b1fb29f8957d4")!)
                    .foregroundColor(.black)
                
                Text(" 버전 정보")
                
                Button(" 닉네임 변경") {
                //showSignInView.toggle()
                    coordinator.push(.settingView, page: .changeGromitUserNameView)
                    
                }
                .fullScreenCover(isPresented: $showSignInView) {
                    ChangeNameView()
                }
                .foregroundColor(.black)
                
            Button(" 로그아웃") {
                self.showingAlert.toggle()
            }
            .foregroundColor(.black)
            .alert(isPresented: $showingAlert) {
                let firstButton = Alert.Button.default(Text("OK")) {
                    print("primary button pressed")
                    settingsViewModel.removeToken()
                    // 로그인 페이지로 이동 후 다시 로그인했을 때 화면 전환이 안 됨
                    coordinator.rootPage = .signInView
                }
                let secondButton = Alert.Button.cancel(Text("Cancel")) {
                    print("secondary button pressed")
                }
                return Alert(title: Text("로그아웃 하시겠습니까?"),
                primaryButton: firstButton, secondaryButton: secondButton)
            }
                
            Button(" 서비스 탈퇴") {
                self.showingAlert2.toggle()
            }
            .foregroundColor(.black)
            .alert(isPresented: $showingAlert2) {
                let firstButton = Alert.Button.default(Text("돌아가기")) {
                    print("primary button pressed")
                }
                let secondButton = Alert.Button.cancel(Text("탈퇴하기")) {
                    print("secondary button pressed")
                }
                return Alert(title: Text("탈퇴를 진행할 경우 모든 정보가 삭제됩니다. 정말 탈퇴하시겠습니까?"),
                    primaryButton: firstButton, secondaryButton: secondButton)
            }}
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
