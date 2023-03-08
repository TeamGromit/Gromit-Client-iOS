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

class InputUserNameViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    var requestUserName = String()
    
    enum OutputEvent {
        case isExistGromitUser, isNotExistGromitUser, createGromitUser, requestError
    }
    @Published var outputEvent: OutputEvent? = nil

    
    @Published var responseUserName = String()
    var responseMessage = String()
    
    @Published var accessToken = String()
    @Published var refreshToken = String()
    
    @AppStorage("rootPage") var rootPage: RootPage = .signInView

    init() {
        print(#fileID, #function, #line, "")
        //inputUserName(rUserName: self.requestUserName)
        //postSignUp(rNickname: "", rgithubName: "", rEmail: "", rProvider: "")
    }
    
//    func inputUserName(rUserName: String) {
//        print(#fileID, #function, #line, "")
//        AF.request("\(GeneralAPI.baseURL)/users/check/\(rUserName)")
//            .publishDecodable(type: InputUserNameEntity.self)
//            .compactMap { $0.value }
//            .sink(receiveCompletion: { complete in
//                print("데이터스트림 완료")
//            }, receiveValue: { (receivedValue : InputUserNameEntity) in
//                print("받은 값: \(receivedValue.description)")
//                if (receivedValue.isSuccess) { // 성공
//                    self.responseUserName = receivedValue.result.nickname
//                } else { // 실패
//                    self.responseUserName = ""
//                }
//                self.responseMessage = receivedValue.message
//                print("code: \(receivedValue.code) / message: \(receivedValue.message)")
//            }).store(in: &subscription)
//    }
    
//    func postSignUp(rNickname: String, rgithubName: String, rEmail: String, rProvider: String) {
//        print(#fileID, #function, #line, "")
//
//        var request = URLRequest(url: URL(string: "\(GeneralAPI.baseURL)/users")!)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.timeoutInterval = 10
//        let params = ["nickname":rNickname, "githubName":rgithubName, "email":rEmail, "provider":rProvider] as Dictionary
//        do {
//            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
//        } catch {
//            print("http Body Error")
//        }
//
//        AF.request("\(GeneralAPI.baseURL)/users")
//            .publishDecodable(type: SignInEntity.self)
//            .compactMap { $0.value }
//            .sink(receiveCompletion: { complete in
//                print("데이터스트림 완료")
//            }, receiveValue: { receivedValue in
//                print("받은 값: \(receivedValue.description)")
//                if (receivedValue.code == 1000) { // 성공
//                    self.accessToken = receivedValue.result.accessToken
//                    self.refreshToken = receivedValue.result.refreshToken
//                } else { // 실패
//
//                }
//                print("sign up - code: \(receivedValue.code) / message: \(receivedValue.message)")
//            }).store(in: &subscription)
//    }
    /// ================================================================================================
    func requestCheckUserNickName(_ nickName: String) {
        NetworkingClinet.shared.request(serviceURL: .requestGetNickName, pathVariable: [nickName], httpMethod: .get, type: InputUserNameEntity.self) { responseData, error in
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
    
    func requestSignUpUser() {
        guard let githubName = UserDefaults.standard.string(forKey: "githubName") else { return }
        guard let email = UserDefaults.standard.string(forKey: "email") else { return }
        guard let provider = UserDefaults.standard.string(forKey: "provider") else { return }
// 킴쿡 : 테스트를 위해서 주석처리
// 주석을 해제 할 경우 서버 DB에 등록돼 재테스트시 문제가 발생 할 수 있음
//        NetworkingClinet.shared.request(serviceURL: .requestPostSignUp, httpMethod: .post, parameter: signUpUser, type: SignUpEntity.self) { responseData, error in
//            if let error = error {
//
//            } else {
//                if let responseData = responseData, let responseMessage = responseData.1, let response = responseData.0{
//                    print(response)
//                    if(responseMessage.code == 1000) {
//                        self.outputEvent = .createGromitUser
//                    } else {
//
//                    }
//                }
//            }
//        }
        self.rootPage = .gromitMainView
        self.outputEvent = .createGromitUser
    }
                                        
}
                                        
