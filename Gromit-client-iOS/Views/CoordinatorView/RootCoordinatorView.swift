//
//  CoordinatorView.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/02/17.
//

import SwiftUI

struct RootCoordinatorView: View {
    // LOGIC: 로그인 이력 체크
    @StateObject private var coordinator = Coordinator(isExistLoginHistory: LoginService.shared.isExistLoginHistory())


    var body: some View {
        ZStack {
            if(coordinator.rootPage == .signInView) {
                NavigationStack(path: $coordinator.sigInViewPath) {
                    coordinator.build(page: .signInView)
                        .navigationDestination(for: Page.self) { page in
                            coordinator.build(page: page)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                        }
                }
            } else {
                TabView(selection: $coordinator.tabSelection) {
                    NavigationStack(path: $coordinator.participatingListViewPath) {
                        coordinator.build(page: .participatingListView)
                            .navigationDestination(for: Page.self) { page in
                                coordinator.build(page: page)
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                            }
                        
                    }
                    .tabItem{
                        Image("challenge")
                    }.tag(1)
                    
                    NavigationStack(path: $coordinator.homeViewPath) {
                        coordinator.build(page: .homeView)
                            .navigationDestination(for: Page.self) { page in
                                coordinator.build(page: page)
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                            }
                    }
                    .tabItem{
                        Image("home")
                    }.tag(2)
                    
                    NavigationStack(path: $coordinator.settingViewPath) {
                        coordinator.build(page: .settingView)
                            .navigationDestination(for: Page.self) { page in
                                coordinator.build(page: page)
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                            }

                    }
                    .tabItem{
                        Image("settings")
                    }.tag(3)
                }
            }
        
            if coordinator.isLoading {
                coordinator.buildLoadingView()
            }
            
            if coordinator.isPopuping {
                coordinator.buildPopupView()
                
            }
        }
        .fullScreenCover(item: $coordinator.fullScreenCover) { fullScrrenCover in
            coordinator.build(fullScreenCover: fullScrrenCover)
        }
        .sheet(item: $coordinator.sheet) {
            sheet in
            coordinator.build(sheet: sheet)
        }
        .environmentObject(coordinator)
    }
    
    init() {
        print("RootCoordinatorView init")
        AppDataService.shared.printInfo()
    }
    
}

struct RootCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        RootCoordinatorView()
    }
}
