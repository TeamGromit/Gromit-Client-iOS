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
        // iOS 16버전은 NavigationStack 사용해야
//        if showDetail {
//            ChallengeDetailView(show: $show)
//        }
        NavigationView {
            VStack {
                NavigationLink(destination: ParticipatingListView(), tag: 1, selection: $tag) {
                    HStack {
//                        Spacer()
//                        Button("참여 챌린지") {
//                            tag = 1
//                        }
//                        .font(.system(size: 16))
//                        .foregroundColor(Color(.gray))
//                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 30)
//                                .stroke(Color(.gray))
//                        )
                    }
                    .navigationTitle("챌린지 목록")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("참여 챌린지") {
                                tag = 1
                            }
                            .font(.system(size: 16))
                            .foregroundColor(Color(.gray))
                            .padding(EdgeInsets(top: 3, leading: 8, bottom: 3, trailing: 0))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color(.gray))
                                )
                            }
                        ToolbarItem {
                            Button("챌린지 생성") {
                                showCreation.toggle()
                            }
                            .sheet(isPresented: $showCreation) {
                                CreationView()
                            }
                            .font(.system(size: 16))
                            .foregroundColor(Color(.gray))
                            .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color(.gray))
                                )
                            }
                        }

//                        Button("+") {
//                            showCreation.toggle()
//                        }
//                        .sheet(isPresented: $showCreation) {
//                             CreationView()
//                         }
//                        .font(.system(size: 16))
//                        .foregroundColor(Color(.gray))
//                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 30)
//                                .stroke(Color(.gray))
//                        )
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                ChallengeCell()
//                List(0..<20) { item in
//                    VStack(alignment: .leading, spacing: 5) {
//                        Text("20자이내로제목을작성해주세요감사합니다")
//                            .fontWeight(.semibold)
//                            .lineLimit(1)
//                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
//                        HStack {
//                            Spacer()
//                            Text("23/01/03")
//                        }
//                        HStack {
//                            Text("목표 커밋: 100")
//                            Spacer()
//                            Text("1/6")
//                        }
//                    }
//                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
//                    .background(Color("yellow500"))
//                    .cornerRadius(20)
//                    .shadow(color: Color("gray500"), radius: 5, y: 5)
//                    .onTapGesture {
//                        showDetail.toggle()
//                    }
//                }
                .listStyle(PlainListStyle())
            }
        }
        .tint(Color("gray700"))
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

struct ChallengeDetailView: View {
    @Binding var show: Bool
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            VStack {
                Image("lockopen")
                Text("20자이내로제목을작성해주세요감사합니다")
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(1)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                HStack {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack(spacing: 25) {
                            Text("방장")
                                .font(.system(size: 16, weight: .semibold))
                            Text("github_ username")
                        }
                        HStack(spacing: 25) {
                            Text("목표")
                            Text("10 커밋")
                        }
                        HStack(spacing: 25) {
                            Text("기간")
                            Text("2023/01/01 - 2023/12/31")
                        }
                    }
                    Spacer()
                }
                Button {
                    withAnimation {
                        show.toggle()
                    }
                } label: {
                    Text("취소")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.35))
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}
