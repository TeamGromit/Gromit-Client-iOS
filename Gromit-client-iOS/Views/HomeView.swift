//
//  HomeView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HomeButtons()
            
            TodaysCommit()
            
            CharacterView()
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
            
            CharacterInfo()
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
    
    var body: some View {
        HStack {
            Button {
                
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
        .fullScreenCover(isPresented: $showParticipating) {
            CollectionListView()
        }
        .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
    }
}
struct TodaysCommit: View {
    var numOfCommit = 23
    
    var body: some View {
        HStack {
            VStack(spacing: 12) {
                Text("오늘의 커밋")
                    .font(.system(size: 20, weight: .semibold))
                Text("\(numOfCommit)")
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
    }
}

struct CharacterLevelBar: View {
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
                .frame(width: maxWidth, height: 55)
        }
        .fixedSize(horizontal: false, vertical: true)
        .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(Color(.black)))
    }
}

struct CharacterInfo: View {
    var level = 0
    var levelName = "알"
    var exp = 52
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text("Lv.\(level) \(levelName) ( \(exp) / 100 )")
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
