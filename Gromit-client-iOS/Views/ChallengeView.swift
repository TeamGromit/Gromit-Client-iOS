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
//        ZStack {
//            NavigationView {
//                ZStack {
//                    NavigationLink(destination: ParticipatingListView(), tag: 1, selection: $tag) {
//                        VStack {
//                            HStack {
//                                Spacer()
//                                Group {
//                                    Button("참여 챌린지") {
//                                        tag = 1
//                                    }
//                                    .buttonStyle(.bordered)
//                                    .cornerRadius(20)
//                                }
//                                Group {
//                                    Button("+") {
//                                        tag = 2
//                                    }
//                                    .buttonStyle(.bordered)
//                                    .cornerRadius(20)
//                                }
//                            }
//                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 10))
//                            ChallengeCell()
//                        }
//                    }
//                    .navigationBarTitle("")
//                    .navigationBarHidden(true)
//                    .navigationBarBackButtonHidden(true)
//                }
//                ZStack {
//                    NavigationLink(destination: ParticipatingListView(), tag: 1, selection: $tag) {
//                        VStack {
//                            HStack {
//                                Spacer()
//                                Group {
//                                    Button("참여 챌린지") {
//                                        tag = 1
//                                    }
//                                    .buttonStyle(.bordered)
//                                    .cornerRadius(20)
//                                }
//                                Group {
//                                    Button("+") {
//                                        tag = 2
//                                    }
//                                    .buttonStyle(.bordered)
//                                    .cornerRadius(20)
//                                }
//                            }
//                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 10))
//                            ChallengeCell()
//                        }
//                    }
//                    .navigationBarTitle("")
//                    .navigationBarHidden(true)
//                    .navigationBarBackButtonHidden(true)
//                }
//            }
//        }
        
        
        NavigationView {
            NavigationLink(destination: ParticipatingListView(), tag: 1, selection: $tag) {
                ChallengeCell()
                    .toolbar {
                        ToolbarItem {
                            Button("참여 챌린지") {
                                tag = 1
                            }
                        }
                        ToolbarItem {
                            Button("+") {
                                showCreation.toggle()
                            }
                            .sheet(isPresented: $showCreation) {
                                CreationView()
                            }
                        }
                    }
            }
        }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
