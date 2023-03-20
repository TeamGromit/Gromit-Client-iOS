//
//  InputUserNameViewModel.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/02/02.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class ChangeNameViewModel: ObservableObject {
    enum OutputEvent {
        case isExistGromitUser, isNotExistGromitUser, changeGromitNickName, requestError
    }
    @Published var outputEvent: OutputEvent? = nil
    
    func requestCheckUserNickName(_ nickName: String) {
        print("requestCheckUserNickName run / nickName : \(nickName)")
        NetworkingClinet.shared.request(serviceURL: .requestGetNickName, pathVariable: [nickName], httpMethod: .get, type: InputUserNameEntity.self) { responseData, error in
            debugPrint(responseData)
            debugPrint(error)
            
            if let error = error {
                self.outputEvent = .requestError
            } else {
                if let responseData = responseData, let responseMessage = responseData.1 {
                    if(responseMessage.code == 1000) {
                       // 닉네임
                       // 다시한번 팝업을 통해 물어보기
                        self.outputEvent = .isNotExistGromitUser
                    } else if(responseMessage.code == 3006) {
                        // 중복 닉네임
                        self.outputEvent = .isExistGromitUser
                    }
                }
            }
        }
    }
    
    func reqeustChangeUserNickName(_ nickName: String) {
        guard let token = AppDataService.shared.getData(appData: .accessToken) else {
            print("Guard Error token is nil")
            return
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-AUTH-TOKEN": token
        ]
        NetworkingClinet.shared.request(serviceURL: .requestChangeGromitNickName, httpMethod: .patch, parameter: RequestChangeNickNameMessage(nickname: nickName), headers: headers, type: ResponseChangeNickNameMessage.self) { responseData, error in
            
            debugPrint(responseData)
            debugPrint(error)
            
            if let error = error {
                self.outputEvent = .requestError
            } else {
                if let responseData = responseData, let responseMessage = responseData.1 {
                    if(responseMessage.code == 1000) {
                        AppDataService.shared.setData(appData: .gromitUserName, value: nickName)
                        self.outputEvent = .changeGromitNickName
                    } else  {
                      
                        self.outputEvent = .requestError
                    }
                }
            }
        }
    }
}
                                        
