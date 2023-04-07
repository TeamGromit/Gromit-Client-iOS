//
//  ParticipatingDetailView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/02/17.
//

import SwiftUI

struct ParticipatingDetailView: View {
    var challenge: Challenge
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    
                    Image("trash")
                    
//                    Image(systemName: "multiply")
                }
                HStack {
                    Image("lockopen")
                    Text(challenge.title)
                        .font(.system(size: 17, weight: .semibold))
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
                
                HStack {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack(spacing: 25) {
                            Text("방장")
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
                
                HStack(spacing: 25) {
                    Text("멤버")
                    Text("6 / 6")
                }
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 5, trailing: 0))
                
                List(0..<6) { item in
                    VStack(spacing: 0) {
                        HStack {
                            Text("멤버 이름")
                            Spacer()
                            Text("100 / 120")
                        }
                        .font(.system(size: 16))
                        .lineLimit(1)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
                        ProgressMemberBar()
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
                    .background(Color("yellow500"))
                    .cornerRadius(20)
                    .shadow(color: Color("gray500"), radius: 5, y: 5)
                }
                .listStyle(PlainListStyle())
            }
            .padding()
//            .overlay(
//                RoundedRectangle(cornerRadius: 20)
//                    .stroke(Color("green500"), lineWidth: 2)
//            )
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
    }
}

struct ProgressMemberBar: View {
    @State private var containerWidth: CGFloat = 0
    @State private var step = 100
    private let goal = 120
    
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
                .frame(width: maxWidth, height: 16)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}


struct ParticipatingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipatingDetailView(challenge: ChallengeList.participatingList.first!)
    }
}
