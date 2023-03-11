//
//  CoordinatorView.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/02/17.
//

import SwiftUI

struct RootCoordinatorView: View {
    
    @StateObject private var coordinator = Coordinator()

    var body: some View {
        ZStack {
            NavigationStack(path: $coordinator.path){
                coordinator.rootBuild()
                    .navigationDestination(for: Page.self) { page in
                        coordinator.build(page: page)
                    }
            }
            .fullScreenCover(item: $coordinator.fullScreenCover) { fullScrrenCover in
                coordinator.build(fullScreenCover: fullScrrenCover)
            }
//            .alert(item: $coordinator.alertPopup, content: { alert in
//                coordinator.build(alert: alert)
//            })
            .environmentObject(coordinator)
            
            if coordinator.isLoading {
                coordinator.buildLoadingView()
            }
            
            if coordinator.isPopuping {
                coordinator.buildPopupView()
                    
            }
        }
    }
    
}

struct RootCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        RootCoordinatorView()
    }
}
