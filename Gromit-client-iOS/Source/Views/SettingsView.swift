import SwiftUI

struct ContentView: View {
    
    @State private var toggling = false
    @State private var showingToggle = false
    @State var date = Date()
    @State private var showingAlert = false
    
    var body: some View {
        
        NavigationView {
            Form {
                    Toggle(isOn: $showingToggle) {
                        Text(" 알람")
                    }
                    
                    if showingToggle {
                        Button(action: {
                        }) {
                                    DatePicker(
                                      "시간을 설정하세요",
                                      selection: $date,
                                      displayedComponents: [.hourAndMinute]
                                    )
                                  }
                        }
                
                Link(" 이용약관", destination: URL(string: "https://www.notion.so/Gromit-Team-27c8612cb66a446b962b1fb29f8957d4")!)
                    .foregroundColor(.black)
                
                Text(" 버전 정보")
                
                Button(" 로그아웃") {
                          self.showingAlert.toggle()
                      }
                      .foregroundColor(.black)
                      .alert(isPresented: $showingAlert) {
                          let firstButton = Alert.Button.default(Text("OK")) {
                              print("primary button pressed")
                          }
                          let secondButton = Alert.Button.cancel(Text("Cancel")) {
                              print("secondary button pressed")
                          }
                          return Alert(title: Text("로그아웃 하시겠습니까?"),
                                       primaryButton: firstButton, secondaryButton: secondButton)
                      }
                
                Button(" 서비스탈퇴") {
                          self.showingAlert.toggle()
                      }
                      .foregroundColor(.black)
                      .alert(isPresented: $showingAlert) {
                          let firstButton = Alert.Button.default(Text("돌아가기")) {
                              print("primary button pressed")
                          }
                          let secondButton = Alert.Button.cancel(Text("탈퇴하기")) {
                              print("secondary button pressed")
                          }
                          return Alert(title: Text("탈퇴를 진행할 경우 모든 정보가 삭제됩니다. 정말 탈퇴하시겠습니까?"),
                                       primaryButton: firstButton, secondaryButton: secondButton)
                      }
                  }
              }
                        }
                        }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
