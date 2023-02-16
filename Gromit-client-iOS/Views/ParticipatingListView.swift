//
//  ParticipatingListView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/21.
//

import SwiftUI

struct ParticipatingListView: View {
    var body: some View {
        VStack {
//            ParticipatingButton()
            
            ParticipatingCell()
        }
    }
}

struct ParticipatingListView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipatingListView()
    }
}

struct ParticipatingButton: View {
    @State private var showChallengeList = false
    
    var body: some View {
        HStack {
            Spacer()
            Button("챌린지 목록") {
                showChallengeList.toggle()
            }
            .fullScreenCover(isPresented: $showChallengeList) {
                ChallengeView()
            }
            .buttonStyle(.bordered)
            .cornerRadius(20)
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
    }
}

struct ParticipatingCell: View {
    var body: some View {
        List(0..<20) { item in
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("20자이내로제목을작성해주세요감사합니다")
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
                HStack {
                    Spacer()
                    Text("23/01/03")
                }
                HStack {
                    Text("80 / 100")
                }
                ProgressBar()
            }
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
            .background(Color("yellow500"))
            .cornerRadius(20)
            .shadow(color: Color("gray500"), radius: 5, y: 5)
        }
        .listStyle(PlainListStyle())
    }
}

struct CompletedCell: View {
    var body: some View {
        List(0..<20) { item in
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("20자이내로제목을작성해주세요감사합니다")
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                HStack {
                    Spacer()
                    Text("챌린지 기한 마감")
                }
                HStack {
                    Text("100 커밋")
                    HStack {
                        Text("성공")
                            .padding(EdgeInsets(top: 1, leading: 10, bottom: 1, trailing: 10))
                    }
                    .background(Color("green500"))
                    .cornerRadius(CGFloat(20))
                    
                }
            }
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
            .background(Color("yellow500"))
            .cornerRadius(20)
            .shadow(color: Color("gray500"), radius: 5, y: 5)
        }
        .listStyle(PlainListStyle())
    }
}

struct SizePreferenceKey: PreferenceKey{
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

struct ProgressBar: View {
    @State private var containerWidth: CGFloat = 0
    @State private var step = 8
    private let goal = 10
    
    var maxWidth: Double {
        return min((containerWidth / CGFloat(goal) * CGFloat(step)), containerWidth)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.clear)
                    .onAppear {
                        containerWidth = geo.size.width
                    }
            }
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.white))
                
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("green500"))
                .frame(width: maxWidth, height: 29)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
