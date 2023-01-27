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
            
            VStack {
                HStack(spacing: 0) {
                    Text("Lv.")
                    Text("0")
                    Text(" ")
                    Text("알")
                    Text(" ( ")
                    Text("52")
                    Text(" / 100 )")
                }
                
                CharacterLevelBar()
                    .frame(width: 277, height: 55)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct HomeButtons: View {
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image("refresh")
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image("collection")
            }
        }
    }
}

struct TodaysCommit: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("오늘의 커밋")
                .font(.system(size: 20))
            Text("23")
                .font(.system(size: 40))
        }
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
    @State private var step = 50
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
