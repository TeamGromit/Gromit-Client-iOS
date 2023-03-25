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
    
    var body: some View {
        VStack {
            HomeButtons()
            
            TodaysCommit()
            
            CharacterView()
                
            CharacterInfo()
        }
        .environmentObject(homeViewModel)
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
    @State private var showingSheet = false
    @EnvironmentObject private var homeViewModel: HomeViewModel

    
    var body: some View {
        
        HStack {
            Button {
                homeViewModel.requestUserInfo()
            } label: {
                Image("refresh")
            }
            
            Spacer()
            Button {
                showParticipating.toggle()
            } label: {
                Image("collection")
            }
        }
        .sheet(isPresented: $showParticipating) {
            CollectionListView()
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
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color("green300"))
                .frame(width: 277, height: 277)
                .overlay(RoundedRectangle(cornerRadius: 30)
                    .stroke(Color("green500"), lineWidth: 5))
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
