//
//  CoordinatorView.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/02/17.
//

import SwiftUI

struct GromitMainView: View {
    
    @StateObject private var coordinator = Coordinator()
    @State private var tabSelection = 2
    init() {
        UITabBar.appearance().backgroundColor = UIColor.clear
        
    }
    var body: some View {
        TabView(selection: $tabSelection) {
            ChallengeListView()
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
        .navigationBarHidden(true)
        //.toolbarBackground(Color.clear, for: .tabBar)
    }
}

struct GromitMainView_Previews: PreviewProvider {
    static var previews: some View {
        GromitMainView()
    }
}
