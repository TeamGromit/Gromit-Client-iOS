//
//  ChallengeDetailView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/02/21.
//

import SwiftUI

struct ChallengeDetailView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        if isShowing {
            ZStack {
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
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
                    Button {
                        withAnimation {
                        }
                    } label: {
                        Text("참가")
                    }
                }
                .padding()
                .onTapGesture {
                    isShowing = false
                }
                .transition(.move(edge: .bottom))
            }
            .animation(.easeInOut)
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
    }
}

struct ChallengeDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        ChallengeDetailView(isShowing: .constant(true))
        ChallengeListView()
    }
}
