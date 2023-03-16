//
//  ParticipatingListView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/21.
//

import SwiftUI

struct TempParticipatingListView: View {
    @State var tag : Int? = nil
    @State private var showCreation = false
    @EnvironmentObject private var coordinator: Coordinator

    
    var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Button("전체 챌린지") {
                        coordinator.push(.participatingListView, page: .challengeListView)
                    }
                    .frame(width: 100, height: 40)
                    .font(.system(size: 18))
                    .foregroundColor(Color(.gray))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color(.gray))
                    )
                    
                    Spacer(minLength: 40)
                    Text("참여 챌린지")
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                    
                    Spacer(minLength: 40)
                    
                    Button("챌린지 생성") {
                        showCreation.toggle()
                    }
                    .sheet(isPresented: $showCreation) {
                        CreationView()
                    }
                    .frame(width: 100, height: 40)
                    .font(.system(size: 18))
                    .foregroundColor(Color(.gray))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color(.gray))
                    )
                    Spacer()
                }
                Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 1, alignment: .center).padding(EdgeInsets(top: 3, leading: 20, bottom: 3, trailing: 20))

                ParticipatingCell()
                
            }
    }
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}

struct TempParticipatingListView_Previews: PreviewProvider {
    static var previews: some View {
        TempParticipatingListView()
    }
}
