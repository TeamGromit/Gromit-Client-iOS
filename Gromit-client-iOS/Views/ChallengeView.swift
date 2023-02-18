//
//  ChallengeView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/02/15.
//

import SwiftUI

struct ChallengeView: View {
    @State var tag : Int? = nil
    @State private var showCreation = false
    
    var body: some View {
        // iOS 16버전은 NavigationStack 사용해야
        NavigationView {
            NavigationLink(destination: ParticipatingListView(), tag: 1, selection: $tag) {
                
                VStack {
//                    HStack {
//                        Spacer()
//                        Button("참여 챌린지") {
//                            tag = 1
//                        }
//                        .font(.system(size: 16))
//                        .foregroundColor(Color(.gray))
//                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 30)
//                                .stroke(Color(.gray))
//                        )
//
//                        Button("+") {
//                            showCreation.toggle()
//                        }
//                        .sheet(isPresented: $showCreation) {
//                             CreationView()
//                         }
//                        .font(.system(size: 16))
//                        .foregroundColor(Color(.gray))
//                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 30)
//                                .stroke(Color(.gray))
//                        )
//                    }
//                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    ChallengeCell()
                }
                
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("참여 챌린지") {
                                tag = 1
                            }
                            .font(.system(size: 16))
                            .foregroundColor(Color(.gray))
//                            .padding(EdgeInsets(top: 3, leading: 8, bottom: 3, trailing: 0))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 30)
//                                    .stroke(Color(.gray))
//                            )
                        }
                        ToolbarItem {
                            Button("챌린지 생성") {
                                showCreation.toggle()
                            }
                            .sheet(isPresented: $showCreation) {
                                CreationView()
                            }
                            .font(.system(size: 16))
                            .foregroundColor(Color(.gray))
//                            .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 8))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 30)
//                                    .stroke(Color(.gray))
//                            )
                        }
                    }
            }
            .navigationTitle("챌린지 목록")
            .navigationBarTitleDisplayMode(.inline)
        }
        .tint(Color("gray700"))
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
