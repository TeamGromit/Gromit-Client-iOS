//
//  ChallengeListViewModel.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/03/26.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class ChallengeListViewModel: ObservableObject {
    
    @Published var challenges = [Challenge]()
    
    init() {
        getChallenges()
    }
    
    func getChallenges() {
        guard let token = AppDataService.shared.getData(appData: .accessToken) else {
            print("Guard Error token is nil")
            return
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-AUTH-TOKEN": token
        ]
        
        NetworkingClinet.shared.request(serviceURL: .requestChallenges, httpMethod: .get, type: ResponseAllChallengesMessage.self, headers: headers) { responseData, error in
            if let error = error {
                
            } else {
                if let responseData = responseData, let responseMessage = responseData.1, let code = responseMessage.code {
                    if let debugMessage = responseData.0 {
                        print(debugMessage)
                    }
                    if(code == 1000) {
                        // 챌린지 get 성공
                        let challenge = Challenge(title: responseMessage.result.title!, date: responseMessage.result.startDate!, goal: responseMessage.result.goal!, headCount: responseMessage.result.currentMemberNum!, maxHead: responseMessage.result.recruits!)
                        self.challenges.append(challenge)
                    }
                }
            }
        }
    }
}
