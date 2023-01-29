//
//  ParticipatingListView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/21.
//

import SwiftUI

var title = "20자이내로제목을작성해주세요감사합니다"
var date = "23/01/03"

struct ParticipatingListView: View {
    var body: some View {
        VStack {
            ParticipatingButton()
            
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
                ChallengeListView()
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
                    Text(title)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
                HStack {
                    Spacer()
                    Text(date)
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
    var goalCommit = 100
    
    var body: some View {
        List(0..<20) { item in
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(title)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                HStack {
                    Spacer()
                    Text(title)
                }
                HStack {
                    Text("\(goalCommit) 커밋")
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
    @State private var step = 80
    private let goal = 100
    
    var maxWidth: Double {
        return min((containerWidth / CGFloat(goal) * CGFloat(step)), containerWidth)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(step) / 100")
                Spacer()
            }
            ZStack(alignment: .leading) {
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 60)
                        .foregroundColor(.clear)
                        .onAppear {
                            containerWidth = geo.size.width
                        }
                }
                RoundedRectangle(cornerRadius: 60)
                    .fill(Color(.white))
                    
                RoundedRectangle(cornerRadius: 60)
                    .fill(Color("green500"))
                    .frame(width: maxWidth, height: 27)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}
