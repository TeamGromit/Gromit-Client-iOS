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
                    List(0..<20) { item in
                        VStack(alignment: .leading, spacing: 5) {
                            Text("20자이내로제목을작성해주세요감사합니다")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                            HStack {
                                Spacer()
                                Text("23/01/03")
                            }
                            HStack {
                                Text("목표 커밋: 100")
                                Spacer()
                                Text("1/6")
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
            .tint(Color("gray700"))
        }
    }
}

struct ChallengeCell: View {
    @State var showDetail = false
    
    var body: some View {
        List(0..<20) { item in
            VStack(alignment: .leading, spacing: 5) {
                Text("20자이내로제목을작성해주세요감사합니다")
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                HStack {
                    Spacer()
                    Text("23/01/03")
                }
                HStack {
                    Text("목표 커밋: 100")
                    Spacer()
                    Text("1/6")
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
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}
