//
//  CoordinatorView.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/02/17.
//

import SwiftUI

struct GromitMainView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @State private var tabSelection = 2
    private var navigationBarTitle: String {
        if(tabSelection == 1) {
            return "참여 챌린지"
        } else if (tabSelection == 2) {
            return "홈"
        } else if (tabSelection == 3) {
            return "설정"
        } else {
            return "홈"
        }
    }
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        TabView(selection: $tabSelection) {
            //ParticipatingListView()
            TempParticipatingListView()
                .tabItem{
                    Image("challenge")
                }.tag(1)
                
            HomeView()
                .tabItem{
                    Image("home")
                }.tag(2)
                
            SettingsView()
                .tabItem{
                    Image("settings")
                }.tag(3)
        }
        
        .fullScreenCover(item: $coordinator.fullScreenCover, content: { fullScreenCover in
            coordinator.build(fullScreenCover: fullScreenCover)
        })
        .environmentObject(coordinator)
        //.navigationBarTitle(navigationBarTitle)
        .navigationBarHidden(true)
        //.toolbarBackground(Color.clear, for: .tabBar)
    }
}

struct GromitMainView_Previews: PreviewProvider {
    static var previews: some View {
        GromitMainView()
    }
}
