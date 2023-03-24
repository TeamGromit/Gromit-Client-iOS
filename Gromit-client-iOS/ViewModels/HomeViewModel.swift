//
//  HomeViewModel.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/03/24.
//

import Foundation
import Alamofire
import SwiftUI

class HomeViewModel: ObservableObject {
    
    enum OutputEvent {
        case requestError, loading, loaded
    }
    
    @Published var outputEvent: OutputEvent? = nil
    @Published var commits: Int? = nil
    @Published var todayCommit: String = ""
   

    @Published var levelString: String = ""
    
    var level: Int? = nil
    var name: String? = nil
    var charecter: UIImage? = nil
    var goal: Int? = nil
    
//    "commits": 0,
//            "todayCommit": 0,
//            "level": 1,
//            "name": "egg",
//            "img": "/home/ubuntu/characters/level1_egg.png",
//            "goal": 10
    init() {
        outputEvent = .loading
        requestUserInfo()
    }
    
    func requestUserInfo() {
        guard let token = AppDataService.shared.getData(appData: .accessToken) else {
            print("Guard Error token is nil")
            return
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-AUTH-TOKEN": token
        ]
        
        NetworkingClinet.shared.request(serviceURL: .requestUserInfo, httpMethod: .get, headers: headers, type: RequestUserInfoEntity.self, completion: {
            responseData, error in
            if let error = error {
                self.outputEvent = .requestError
            } else {
                if let responseData = responseData, let responseMessage = responseData.1, let code = responseMessage.code {
                    if(code == 1000) {
                        if let reponseMessageResult = responseMessage.result {
                            if let commits = reponseMessageResult.commits {
                                self.commits = commits
                            }
                            if let todayCommit = reponseMessageResult.todayCommit {
                                self.todayCommit = "\(todayCommit)"
                            }
                            if let level = reponseMessageResult.level {
                                self.level = level
                            }
                            if let name = reponseMessageResult.name {
                                self.name = name
                            }
                            if let imageURL = reponseMessageResult.img {
                                self.requestCharecterImg(url: imageURL)
                            }
                            if let goal = reponseMessageResult.goal {
                                self.goal = goal
                            }
                            
                            self.updateLevelString()
                            self.outputEvent = .loaded
                        }
                    }
                }
            }
        })
    }
    
    func updateLevelString() {
        let level = self.level ?? 0
        let name = self.name ?? ""
        let goal = self.goal ?? 0
        
        
        self.levelString = "Lv.\(level) \(name) ( \(goal) / 100 )"
    }
    
    func requestCharecterImg(url: String) {
        NetworkingClinet.shared.requestURLImage(imageURL: "\(GeneralAPI.baseURL)/\(url)", completion: { image in
            self.charecter = image
        })
    }
}
