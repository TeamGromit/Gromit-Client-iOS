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
    
    init() {
        print(#fileID, #function, #line, "")
        inputUserName(rUserName: self.requestUserName)
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
}
