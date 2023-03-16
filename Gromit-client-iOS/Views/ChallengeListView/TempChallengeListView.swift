//
//  ChallengeListView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/02/15.
//

import SwiftUI

struct TempChallengeListView: View {
    @State var tag : Int? = nil
    @State private var showCreation = false
    @State var showDetail = false
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    HStack {
                        Spacer()
                        Button("뒤로가기") {
                            coordinator.pop(.participatingListView)
                        }
                        .frame(width: 100, height: 40)
                        .font(.system(size: 18))
                        .foregroundColor(Color(.gray))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(.gray))
                        )
                        
                        Spacer(minLength: 40)
                        Text("전체 챌린지")
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                        
                        Spacer(minLength: 40)
                        
                        Button("오른쪽버튼") {
                            
                        }
                        .frame(width: 100, height: 40)
                        .font(.system(size: 18))
                        .foregroundColor(Color(.gray))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(.gray))
                        )
                        .hidden()
                        Spacer()
                        
                    }
                    Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 1, alignment: .center).padding(EdgeInsets(top: 3, leading: 20, bottom: 3, trailing: 20))
                    ChallengeCell()
                }
            }
            .tint(Color("gray700"))
        }
    }
}


struct TempChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        TempChallengeListView()
    }
}
