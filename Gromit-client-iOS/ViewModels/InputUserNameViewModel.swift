//
//  InputUserNameViewModel.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/02/02.
//

import Foundation
import Combine
import Alamofire

class InputUserNameViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    var requestUserName = String()
    @Published var responseUserName = String()
    var responseMessage = String()
    
    @Published var accessToken = String()
    @Published var refreshToken = String()
    
    init() {
        print(#fileID, #function, #line, "")
        inputUserName(rUserName: self.requestUserName)
        postSignUp(rNickname: "", rgithubName: "", rEmail: "", rProvider: "")
    }
    
    func inputUserName(rUserName: String) {
        print(#fileID, #function, #line, "")
        AF.request("\(GeneralAPI.baseURL)/users/check/\(rUserName)")
            .publishDecodable(type: InputUserNameEntity.self)
            .compactMap { $0.value }
            .sink(receiveCompletion: { complete in
                print("데이터스트림 완료")
            }, receiveValue: { (receivedValue : InputUserNameEntity) in
                print("받은 값: \(receivedValue.description)")
                if (receivedValue.isSuccess) { // 성공
                    self.responseUserName = receivedValue.result.nickname
                } else { // 실패
                    self.responseUserName = ""
                }
                self.responseMessage = receivedValue.message
                print("code: \(receivedValue.code) / message: \(receivedValue.message)")
            }).store(in: &subscription)
    }
    
    func postSignUp(rNickname: String, rgithubName: String, rEmail: String, rProvider: String) {
        print(#fileID, #function, #line, "")
        
        var request = URLRequest(url: URL(string: "\(GeneralAPI.baseURL)/users")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        let params = ["nickname":rNickname, "githubName":rgithubName, "email":rEmail, "provider":rProvider] as Dictionary
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request("\(GeneralAPI.baseURL)/users")
            .publishDecodable(type: SignInEntity.self)
            .compactMap { $0.value }
            .sink(receiveCompletion: { complete in
                print("데이터스트림 완료")
            }, receiveValue: { receivedValue in
                print("받은 값: \(receivedValue.description)")
                if (receivedValue.code == 1000) { // 성공
                    self.accessToken = receivedValue.result.accessToken
                    self.refreshToken = receivedValue.result.refreshToken
                } else { // 실패
                    
                }
                print("sign up - code: \(receivedValue.code) / message: \(receivedValue.message)")
            }).store(in: &subscription)
    }
}
