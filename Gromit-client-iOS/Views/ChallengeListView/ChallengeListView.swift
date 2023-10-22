//
//  ChallengeListView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/02/15.
//

import SwiftUI

struct ChallengeListView: View {
    @State var tag : Int? = nil
    @State private var showCreation = false
    @State var showDetail = false
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    NavigationBarView(isActiveLeftButton: true, isActiveRightButton: false, title: "전체 챌린지", leftButtonTitle: "뒤로가기", leftButtonTapped: {
                        //coordinator.pop(.participatingListView)
                    })
                    Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 1, alignment: .center).padding(EdgeInsets(top: 3, leading: 20, bottom: 3, trailing: 20))
                    ChallengeCell()
                }
            }
            .tint(Color("gray700"))
        }
    }
}

struct ChallengeCell: View {
    @State var showDetail = false
    @StateObject var challengeListViewModel = ChallengeListViewModel()
    // dummy data
    var challenges: [Challenge] = ChallengeList.allChallengeList
    
    var body: some View {
        // Detail view와 Model 연결 작업중...
        List(challenges, id: \.id) { challenge in
            // 로그 출력이 안됨... 왜지?
            let _ = print("챌린지: \(challenge)")
            VStack(alignment: .leading, spacing: 5) {
                Text(challenge.title)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                HStack {
                    Spacer()
                    Text(challenge.startDate)
                }
                HStack {
                    Text("목표 커밋: \(challenge.goal)")
                    Spacer()
                    Text("\(challenge.currentMemberNum) / \(challenge.recuits)")
                }
            }
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
            .background(Color("yellow500"))
            .cornerRadius(20)
            .shadow(color: Color("gray500"), radius: 5, y: 5)
            .onTapGesture {
                showDetail.toggle()
            }
        }
        .listStyle(PlainListStyle())
        .sheet(isPresented: $showDetail) {
            ChallengeDetailView(isShowing: $showDetail)
        }
        
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}
