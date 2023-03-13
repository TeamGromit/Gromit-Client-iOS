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
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    ChallengeCell()
                }
            }
            .tint(Color("gray700"))
        }
    }
}

struct ChallengeCell: View {
    @State var showDetail = false
    var challenges: [Challenge] = AllChallengeList.allChallengeList

    var body: some View {
        // Detail view와 Model 연결 작업중...
        List(challenges, id: \.id) { challenge in
            VStack(alignment: .leading, spacing: 5) {
                Text(challenge.title)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                HStack {
                    Spacer()
                    Text(challenge.date)
                }
                HStack {
                    Text("목표 커밋: \(challenge.goal)")
                    Spacer()
                    Text("\(challenge.headCount) / \(challenge.maxHead)")
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
            ZStack {
                VStack {
                    Image("lockopen")
                    Text("20자이내로제목을작성해주세요감사합니다")
                        .font(.system(size: 18, weight: .semibold))
                        .lineLimit(1)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            HStack(spacing: 25) {
                                Text("방장")
                                    .font(.system(size: 17, weight: .semibold))
                                Text("github_ username")
                            }
                            HStack(spacing: 25) {
                                Text("목표")
                                    .font(.system(size: 17, weight: .semibold))
                                Text("10 커밋")
                            }
                            HStack(spacing: 25) {
                                Text("기간")
                                    .font(.system(size: 17, weight: .semibold))
                                Text("2023 / 01 / 01 - 2023 / 12 / 31")
                            }
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 0))
                    
                    Button {
                        self.showDetail = false
                    } label: {
                        Text("참가")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 300, height: 50)
                            .tint(Color(.white))
                            .background(Color("green500"))
                            .cornerRadius(10)
                    }
                }
                .padding()
                .onTapGesture {
                    self.showDetail = false
                }
                .transition(.move(edge: .bottom))
            }
            .animation(.easeInOut)
            .frame(height: 300, alignment: .bottom)
            .cornerRadius(40)
            .ignoresSafeArea()
        }
//        ChallengeDetailView(isShowing: $showDetail)
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}
