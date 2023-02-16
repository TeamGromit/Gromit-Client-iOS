import SwiftUI

struct CreationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var title: String = ""
    @State var date = Date()
    @State var dates = Date()
    @State private var commit : String = ""
    @State private var people : String = ""
    @State private var passward : String = ""
    @State private var someToggle = true
    @State private var showingToggle = false
    @State private var showingAlert = false
    @State private var showingAlert2 = false

    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack {
            Group{
                Text("챌린지 생성")
                    .padding(.top, -100)
                    .tint(Color.black)
                Text("챌린지 제목")
                    .padding(.leading, -195)
                    .tint(Color.black)
                TextField(
                    "20자 이내로 제목을 작성해주세요 감사합니다",
                    text: $title)
            }
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 1))
            //글자수 제한 구현 필요
            
            Group{
                Text("\n챌린지 기간")
                    .padding(.leading, -195)
                    .tint(Color.black)
                HStack{
                    Group{
                        DatePicker(
                            "   시작일",
                            selection: $date,
                            displayedComponents: [.date]
                        )}
                        DatePicker(
                            "    마감일",
                            selection: $dates,
                            displayedComponents: [.date]
                        )
                    }
            }
            Group{
                Text("\n목표 커밋 수")
                    .padding(.leading, -195)
                    .tint(Color.black)
                
                TextField("목표 커밋 수를 입력해주세요", text: $commit)
                
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 1))
                //textfield 절반으로 줄이기 구현 필요
                
                Text("\n인원 수")
                    .padding(.leading, -195)
                    .tint(Color.black)
                
                TextField("인원수를 입력해주세요", text: $people)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 1))
            }
            
            //인원수 +,- 버튼 누를 시 변경 되는 것 구현 필요
            
            Toggle(isOn: $showingToggle) {
                Text(" 비밀번호")
                    .tint(Color.black)
            }
            
            if showingToggle {
                Button(action: {
                }) {
                    Text("")
                    TextField("비밀번호를 입력해주세요", text: $passward)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                // 영+숫 가능하게, 제한 추가
            }
            Spacer()
                .frame(height: 50)
            
            HStack{
                Button("생성          ") {
                    self.showingAlert.toggle()
                }

                        .buttonStyle(.bordered)
                        .tint(.green)
                        .padding()
                        //그라데이션
                        .cornerRadius(30)
                        .font(.system(size: 20))
                        
                        .alert(isPresented: $showingAlert) {
                            let firstButton = Alert.Button.default(Text("취소")) {
                                print("primary button pressed")
                            }
                            let secondButton = Alert.Button.cancel(Text("생성")) {
                                print("secondary button pressed")
                            }
                            return Alert(title: Text("챌린지를 생성하시겠습니까?"),
                                         primaryButton: firstButton, secondaryButton: secondButton)
                        }
                
                Button("취소          ") {
                    self.showingAlert2.toggle()
                }

                        .buttonStyle(.bordered)
                        .tint(.green)
                        .padding()
                        //그라데이션
                        .cornerRadius(30)
                        .font(.system(size: 20))
                        
                        .alert(isPresented: $showingAlert2) {
                            let firstButton = Alert.Button.default(Text("아니요")) {
                                print("primary button pressed")
                            }
                            let secondButton = Alert.Button.cancel(Text("예")) {
                                print("secondary button pressed")
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            return Alert(title: Text("챌린지 신청을 취소하시겠습니까?"),
                                         message: Text("취소할 경우 작성 내용이 사라집니다"),
                                         primaryButton: firstButton, secondaryButton: secondButton)
                        }
                    }
                }
                    }
                }

    struct CreationView_Previews: PreviewProvider {
        static var previews: some View {
            CreationView()
        }
    }
// 목표 커밋 수, 인원 수, 비밀번호 저장 완료. 단 숫자만 입력 가능하게 해야함
