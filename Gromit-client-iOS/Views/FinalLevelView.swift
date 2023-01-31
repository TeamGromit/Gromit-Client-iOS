//
//  FinalLevelView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/27.
//

import SwiftUI

struct FinalLevelView: View {
    var body: some View {
        VStack {
            FinalLevelText()
            
            CharacterView()
            
            NewCharacterButton()
        }
    }
}

struct FinalLevelView_Previews: PreviewProvider {
    static var previews: some View {
        FinalLevelView()
    }
}

struct FinalLevelText: View {
    var body: some View {
        VStack {
            VStack {
                Text("축하합니다!")
                Text("최종 진화에 도달하였습니다")
            }
            .font(.system(size: 20))
            
            HStack {
                Text("캐릭터 이름")
                    .font(.system(size: 40, weight: .semibold))
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 30, trailing: 0))
        }
    }
}

struct NewCharacterButton: View {
    @State private var showingAlert = false
    
    var body: some View {
        HStack {
            Button {
                self.showingAlert.toggle()
            } label: {
                Text("새로 키우기")
                    .frame(width: 160, height: 34)
                    .font(.system(size: 16))
                    .foregroundColor(Color(.black))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("gray500"))
                    )
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("최종 진화에 도달하셨습니다!\n새로운 캐릭터를 키워보시겠습니까?"),
                    message: Text("기존의 캐릭터는 컬렉션에 추가됩니다."),
                    primaryButton: .default(Text("좋아요"), action: {
                        
                    }),
                    secondaryButton: .cancel(Text("아니요")))
            }
        }
        .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
    }
}
