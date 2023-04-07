//
//  ParticipatingListView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/21.
//

import SwiftUI

struct ParticipatingListView: View {
    @State var tag : Int? = nil
    @EnvironmentObject private var coordinator: Coordinator

    
    var body: some View {
            VStack {
                HStack {
                    NavigationBarView(isActiveLeftButton: true, isActiveRightButton: true, title: "참여 챌린지", leftButtonTitle: "전체 챌린지", rightButtonTitle: "챌린지 생성"
                    , leftButtonTapped: {
                        coordinator.push(.participatingListView, page: .challengeListView)
                    }, rightButtonTapped: {
                        coordinator.present(sheet: .creationView)
                    })
                }
                Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 1, alignment: .center).padding(EdgeInsets(top: 3, leading: 20, bottom: 3, trailing: 20))

                TempParticipatingCell()
                
            }
    }
    init() {
        print("TempParticipatingListView init!")
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}

struct TempParticipatingListView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipatingListView()
    }
}


struct TempParticipatingCell: View {
    @EnvironmentObject private var coordinator: Coordinator

    var challenges: [Challenge] = ChallengeList.participatingList
    
    var body: some View {
            List(challenges, id: \.id) { challenge in
                ZStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(challenge.title)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        }
                        HStack {
                            Spacer()
                            Text(challenge.startDate)
                        }
                        HStack {
                            Text("10 / 100")
                        }
                        ProgressBar()
                    }
                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                    .background(Color("yellow500"))
                    .cornerRadius(20)
                    .shadow(color: Color("gray500"), radius: 5, y: 5)
                    .onTapGesture {
                        coordinator.push(.participatingListView, page: .participatingDetailView, challenge: challenge)
                    }
//                    NavigationLink(destination: TempParticipatingDetailView(challenge: challenge)) {
//                        EmptyView()
//                    }.opacity(0.0)

                    
                }
            }
            .listStyle(PlainListStyle())
//        }
        //.navigationTitle("참여 챌린지")
    }
}
