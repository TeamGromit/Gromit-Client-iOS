//
//  GromitMainView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/21.
//

import SwiftUI

struct GromitMainView: View {
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            ChallengeView()
                .tabItem() {
                    Image("challenge")
                }
                .tag(0)

            HomeView()
                .tabItem() {
                    Image("home")
                }
                .tag(1)

            SettingsView()
                .tabItem() {
                    Image("settings")
                }
                .tag(2)

            TempView()
                .tabItem() {
                    Text("임시 화면")
                }
                .tag(3)
        }
        
    }
}

struct GromitMainView_Previews: PreviewProvider {
    static var previews: some View {
        GromitMainView()
    }
}
