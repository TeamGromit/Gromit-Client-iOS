import SwiftUI

struct CreationView: View {
    @State var title: String = ""
    @State var commit: String = ""
    @State var isPrivate: Bool = true
    @State var notificationsEnabled: Bool = false
    @State private var previewIndex = 0
    @State var date = Date()
    @State var dates = Date()
    @State private var passward : String = ""
    @State private var showingToggle = false
    @State private var challengeCreation = false
    @State private var showingAlert = false
    
    var previewOptions = ["1명", "2명", "3명", "4명", "5명" ]
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section(header: Text("기본설정")) {
                    TextField("20자 이내의 챌린지 제목을 적어주세요", text: $title)
                    TextField("목표 커밋 수", text: $commit)
                    Group{
                        Toggle(isOn: $showingToggle) {
                            Text(" 비밀번호")
                                .tint(Color.black)
                        }
                        
                        if showingToggle {
                            Button(action: {
                            }) {
                                Text("")
                                TextField("비밀번호를 입력해주세요", text: $passward)
                            }
                        }
                        
                    }}
                
                Section(header: Text("상세설정")) {
                    Picker(selection: $previewIndex, label: Text("모집 인원")) {
                        ForEach(0 ..< previewOptions.count) {
                            Text(self.previewOptions[$0])
                        }
                    }
                }
                
                Group{
                    DatePicker(
                        "시작일",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    DatePicker(
                        "마감일",
                        selection: $dates,
                        displayedComponents: [.date]
                    )}
                
                Section{
                    Button("생성") {
                        self.showingAlert.toggle()
                    }
                    .foregroundColor(.black)
                    .alert(isPresented: $showingAlert) {
                        let firstButton = Alert.Button.default(Text("아니요")) {
                            print("primary button pressed")
                        }
                        let secondButton = Alert.Button.cancel(Text("네")) {
                            print("secondary button pressed")
                        }
                        return Alert(title: Text("생성하시겠습니까?"),
                                     primaryButton: firstButton, secondaryButton: secondButton)
                    }}
                }
                .navigationBarTitle("챌린지 생성")
            }
        }
        
        struct CreationView_Previews: PreviewProvider {
            static var previews: some View {
                CreationView()
            }
        }
    }
