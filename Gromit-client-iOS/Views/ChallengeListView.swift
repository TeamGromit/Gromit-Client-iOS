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
//        List(challenges, id: \.id) { challenge in
//            VStack(alignment: .leading, spacing: 5) {
//                Text(challenge.title)
//                    .fontWeight(.semibold)
//                    .lineLimit(1)
//                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
//                HStack {
//                    Spacer()
//                    Text(challenge.date)
//                }
//                HStack {
//                    Text("목표 커밋: \(challenge.goal)")
//                    Spacer()
//                    Text("\(challenge.headCount) / \(challenge.maxHead)")
//                }
//            }
//            .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
//            .background(Color("yellow500"))
//            .cornerRadius(20)
//            .shadow(color: Color("gray500"), radius: 5, y: 5)
//            .onTapGesture {
//                showDetail.toggle()
//            }
//        }
//        .listStyle(PlainListStyle())
        
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
        
        ChallengeDetailView(isShowing: $showDetail)
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}
