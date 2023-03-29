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
    
    enum CharecterName: String {
        case egg, none
        
        var name: String  {
            switch self {
            case .egg:
                return "알"
            case .none:
                return ""
            }
        }
        
    }
    
    @Published var outputEvent: OutputEvent? = nil
    @Published var todayCommit: String = ""
    @Published var levelString: String = ""
    @Published var levelBarPercent: Double = 0
    @Published var charecter: UIImage = UIImage()

    
    var level: Int? = nil
    var name: String? = nil
    var goal: Int? = nil
    var commits: Int? = nil
    
//    "commits": 0,
//            "todayCommit": 0,
//            "level": 1,
//            "name": "egg",
//            "img": "/home/ubuntu/characters/level1_egg.png",
//            "goal": 10
    init() {
        print("HomeViewModel init !")
        requestUserInfo()
    }
    
    func requestUserInfo() {
        outputEvent = .loading
        guard let token = AppDataService.shared.getData(appData: .accessToken) else {
            print("Guard Error token is nil")
            outputEvent = .loaded
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
                            self.updateLevelBar()
                        }
                    }
                }
            }
        })
    }
    
    func requestReloadUserInfo() {
        outputEvent = .loading
        guard let token = AppDataService.shared.getData(appData: .accessToken) else {
            print("Guard Error token is nil")
            outputEvent = .loaded
            return
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-AUTH-TOKEN": token
        ]
        
        NetworkingClinet.shared.request(serviceURL: .requestReloadUserInfo, httpMethod: .get, headers: headers, type: RequestUserInfoEntity.self, completion: {
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
                            self.updateLevelBar()
                        }
                    }
                }
            }
        })
    }
    
    func updateLevelString() {
        let level = self.level ?? 0
        let charecterName = CharecterName(rawValue: self.name ?? "") ?? .none
        let goal = self.goal ?? 0
        let commits = self.commits ?? 0
        
        
        self.levelString = "Lv.\(level) \(charecterName.name) ( \(commits) / \(goal) )"
    }
    
    func updateLevelBar() {
        let goal = self.goal ?? 0
        let commits = self.commits ?? 0

        self.levelBarPercent = Double(commits) / Double(goal)
    }
    
    func requestCharecterImg(url: String) {
        NetworkingClinet.shared.requestURLImage(imageURL: url, completion: { image in
            if let image = image {
                self.charecter = image
                self.outputEvent = .loaded
            }
        })
    }
}

