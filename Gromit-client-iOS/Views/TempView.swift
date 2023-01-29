//
//  TempView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/21.
//

import SwiftUI

struct TempView: View {
    @State private var showSignIn = false
    @State private var showHome = false
    @State private var showChallengeList = false
    @State private var showParticipatingList = false
    @State private var showSettings = false
    @State private var showSearchGitUser = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("시작 화면") {
                showSignIn.toggle()
            }
            .fullScreenCover(isPresented: $showSignIn) {
                SignInView()
            }
            
            Button("Git User Name 검색") {
                showSearchGitUser.toggle()
            }
            .fullScreenCover(isPresented: $showSearchGitUser) {
                SearchGitUserView()
            }
            
            Button("홈 페이지") {
                showHome.toggle()
            }
            .fullScreenCover(isPresented: $showHome) {
                HomeView()
            }
            
            Button("챌린지 목록") {
                showChallengeList.toggle()
            }
            .fullScreenCover(isPresented: $showChallengeList) {
                ChallengeListView()
            }
            
            Button("참여 챌린지 목록") {
                showParticipatingList.toggle()
            }
            .fullScreenCover(isPresented: $showParticipatingList) {
                ParticipatingListView()
            }
            
            Button("설정") {
                showSettings.toggle()
            }
            .fullScreenCover(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }
}

struct TempView_Previews: PreviewProvider {
    static var previews: some View {
        TempView()
    }
}
