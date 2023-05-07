//
//  SettingsViewModel.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/04/07.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class SettingsViewModel: ObservableObject {
    enum OutputEvent {
        case logout
    }
    
    @Published var outputEvent: OutputEvent? = nil
    @EnvironmentObject private var coordinator: Coordinator
    
    init() {
        print(#fileID, #function, #line, "")
    }
    
    func patchLogout() {
//        let deviceId = UIDevice.current.identifierForVendor!.uuidString
//        print(deviceId)
//        guard let token = AppDataService.shared.getData(appData: .accessToken) else {
//            print("Guard Error token is nil")
//            return
//        }
////        let headers: HTTPHeaders = [
////            "Content-Type": "application/json",
////            "X-AUTH-TOKEN": token
////        ]
//
//        NetworkingClinet.shared.request(serviceURL: .requstLogout, httpMethod: .patch, parameter: RequestLogoutMessage(deviceId: deviceId, accessToken: token), type: ResponseLogoutMessage.self) { responseData, error in
//            if let error = error {
//
//            } else {
//                if let responseData = responseData, let responseMessage = responseData.1, let code = responseMessage.code {
//                    if let debugMessage = responseData.0 {
//                        print(debugMessage)
//                    }
//                    if(code == 200) {
//                        // 로그아웃 성공
//                        self.outputEvent = .logout
//                        self.coordinator.push(.settingView, page: .signInView)
//                        print("로그아웃 성공")
//                    } else {
//                        // 로그아웃 실패
//                    }
//                }
//            }
//        }
        
        AppDataService.shared.removeToken()
        self.outputEvent = .logout
//        self.coordinator.push(.signInView, page: .homeView)
        print("로그아웃 성공")
        
    }
}
