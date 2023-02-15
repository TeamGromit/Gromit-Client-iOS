//
//  ChallengeListView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/21.
//

import SwiftUI

struct ChallengeListView: View {
    var body: some View {
        VStack {
            ChallengeCell()
        }
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}
//
//struct ChallengeButtons: View {
//    @State private var showParticipating = false
//
//    var body: some View {
//        HStack {
//            Group{
//                Spacer()
//                Button("참여 챌린지") {
//                    showParticipating.toggle()
//                }
//                .fullScreenCover(isPresented: $showParticipating) {
//                    CreationView()
//                }
//                .buttonStyle(.bordered)
//                .cornerRadius(20)
//            }
//
//            Group{
//                Button("+") {
//                    showParticipating.toggle()
//                }
//                .fullScreenCover(isPresented: $showParticipating) {
//                    CreationView()
//                }
//                .buttonStyle(.bordered)
//                .cornerRadius(20)
//            }
//            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
//        }}
//}
