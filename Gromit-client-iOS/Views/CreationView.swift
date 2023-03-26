import SwiftUI
import Combine

struct CreationView: View {
    @State var title: String = ""
    @State var goal: String = ""
    @State var isPassword: Bool = false
    @State var notificationsEnabled: Bool = false
    @State private var recruits = 0
    @State var startDate = Date()
    @State var endDate = Date()
    @State private var password : String = ""
    @State private var showingToggle = false
    @State private var challengeCreation = false
    @State private var showingAlert = false
    @StateObject var creationViewModel = CreationViewModel()
    
    var previewOptions = ["1명", "2명", "3명", "4명", "5명" ]
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section(header: Text("기본설정")) {
                    TextField("20자 이내의 챌린지 제목을 적어주세요", text: $title)
                    TextField("목표 커밋 수", text: $goal)
                        .keyboardType(.numberPad)
                        .onReceive(Just(goal)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.goal = filtered
                                        }
                                    }
                    Group{
                        Toggle(isOn: $showingToggle) {
                            Text(" 비밀번호")
                                .tint(Color.black)
                        }
                        
                        if showingToggle {
                            Button(action: {
                            }) {
                                Text("")
                                TextField("비밀번호를 입력해주세요", text: $password)
                            }
                        }
                        
                    }}
                
                Section(header: Text("상세설정")) {
                    Picker(selection: $recruits, label: Text("모집 인원")) {
                        ForEach(0 ..< previewOptions.count) {
                            Text(self.previewOptions[$0])
                        }
                    }
                }
                
                Group{
                    DatePicker(
                        "시작일",
                        selection: $startDate,
                        displayedComponents: [.date]
                    )
                    DatePicker(
                        "마감일",
                        selection: $endDate,
                        displayedComponents: [.date]
                    )}
                
                Section{
                    Button("챌린지 생성") {
                        self.showingAlert.toggle()
                    }
                    .foregroundColor(.blue)
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("챌린지를 생성하시겠습니까?"),
                            primaryButton: .default(Text("좋아요"), action: {
                                if title.isEmpty {
//                                    coordinator.openPopup(popup: .emptyChallengeInfo, okAction: coordinator.closePopup)
                                } else {
                                    print("Complete Input and create...")
                                    // 로그인할 때 UserDefaults에 저장된 토큰을 꺼내 써야 함
//                                    guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else { return }
                                    let sStartDate = creationViewModel.dateToString(date: startDate)
                                    let sEndDate = creationViewModel.dateToString(date: endDate)
                                    let iGoal = creationViewModel.stringToInt(string: goal)
                                    creationViewModel.postCreation(title: title, startDate: sStartDate, endDate: sEndDate, goal: iGoal, recruits: recruits, isPassword: isPassword, password: password)
                                }
                            }),
                            secondaryButton: .cancel(Text("아니요")))
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
