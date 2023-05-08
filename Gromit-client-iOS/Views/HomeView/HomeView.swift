//
//  HomeView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject var homeViewModel = HomeViewModel()
    
    init() {
        print("HomeView init!")
    }
    
    var body: some View {
        VStack {
            HomeButtons()
            
            TodaysCommit()

            CharacterView()

            CharacterInfo()
        }
        .environmentObject(homeViewModel)
        .onAppear {
            homeViewModel.requestUserInfo()
            // 프리뷰 오류시 해당 부분 주석처리
            // 초기 데이터 값을 설정해주지 않았기 때문
        }
        .onReceive(homeViewModel.$outputEvent) { event in
            if let event = event {
                receiveViewModelEvent(event)
            }
        }
    }
 
}

extension HomeView {
    private func receiveViewModelEvent(_ event: HomeViewModel.OutputEvent) {
        switch event {
        case .requestError:
            break
        case .loading:
            coordinator.startLoading()
        case .loaded:
            
            coordinator.stopLoading()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        
    }
}

struct HomeButtons: View {
    @State private var showParticipating = false
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        
        HStack {
            Button {
                homeViewModel.requestReloadUserInfo()
            } label: {
                Image("refresh")
            }
            
            Spacer()
            Button {
                coordinator.present(sheet: .collectionView)
            } label: {
                Image("collection")
            }
        }
        .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
    }
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        navigationBarHidden(false)
    }
}

struct TodaysCommit: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel

    var body: some View {
        HStack {
            VStack(spacing: 12) {
                Text("오늘의 커밋")
                    .font(.system(size: 20, weight: .semibold))
                Text(homeViewModel.todayCommit)
                    .font(.system(size: 40, weight: .semibold))
            }
        }
        .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
    }
}

struct CharacterView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color("green300"))
                .frame(width: 277, height: 277)
                .overlay(RoundedRectangle(cornerRadius: 30)
                    .stroke(Color("green500"), lineWidth: 5))
            
            Image(uiImage: homeViewModel.charecter)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 270, height: 270)
                .cornerRadius(50)

            
        }
        .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
    }
}

struct CharacterLevelBar: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel

    @State private var containerWidth: CGFloat = 0
    @State private var step = 52
    private let goal = 100
    
    var maxWidth: Double {
        return min((277 / CGFloat(goal) * CGFloat(step)), containerWidth)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 60)
                    .foregroundColor(.clear)
                    .onAppear {
                        containerWidth = geo.size.width
                    }
            }
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.white))
                
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("green500"))
                .frame(width: homeViewModel.levelBarPercent * containerWidth, height: 55)
        }
        .fixedSize(horizontal: false, vertical: true)
        .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(Color(.black)))
    }
}

struct CharacterInfo: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text("\(homeViewModel.levelString)")
                        .font(.system(size: 18, weight: .semibold))
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                
                CharacterLevelBar()
                    .frame(width: 277, height: 55)
            }
            .frame(width: 277)
        }
        .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
        Spacer()
    }
}
