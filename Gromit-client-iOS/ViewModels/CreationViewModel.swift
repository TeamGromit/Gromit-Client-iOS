//
//  ChallengeCreationViewModel.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/03/18.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class CreationViewModel: ObservableObject {
    enum OutputEvent {
        case createChallenge, errorChallengeInfo, errorAppleToken, errorServer
    }
    
    @Published var outputEvent: OutputEvent? = nil
    @Published var responseCreation: String? = nil
    
    func postCreation(title: String, startDate: String, endDate: String, goal: Int,
                      recruits: Int, isPassword: Bool, password: String) {
        guard let token = AppDataService.shared.getData(appData: .accessToken) else {
            print("Guard Error token is nil")
            return
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-AUTH-TOKEN": token
        ]
//        let params = ["title":title, "startDate":startDate, "endDate":endDate, "goal":goal,
//                      "recruits":recruits, "isPassword":isPassword, "password":password] as Dictionary
        
        NetworkingClinet.shared.request(serviceURL: .requestChallenges, httpMethod: .post, parameter: RequestCreationMessage(title: title, startDate: startDate, endDate: endDate, goal: goal, recruits: recruits, isPassword: isPassword, password: password), headers: headers, type: ResponseCreationMessage.self) { responseData, error in
            if let error = error {
                
            } else {
                if let responseData = responseData, let responseMessage = responseData.1, let code = responseMessage.code {
                    if let debugMessage = responseData.0 {
                        print(debugMessage)
                    }
                    if(code == 1000) {
                        // 챌린지 생성 성공
                        // 테스트를 위함
                        self.outputEvent = .createChallenge
                    } else if(code == 400) {
                        // 신규 회원
                        self.outputEvent = .errorChallengeInfo
                    } else if(code == 500) {
                        // 애플 통신 실패
                        self.outputEvent = .errorServer
                    } else if(code == 2001) {
                        // 가입되지 않은 유저
                        self.outputEvent = .errorAppleToken
                    } else if(code == 2002) {
                        // 서버 내부 오류
                        self.outputEvent = .errorAppleToken
                    }
                }
            }
        }
    }
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func stringToInt(string: String) -> Int {
        guard let int = Int(string) else { return 0 }
        return int
    }
}
