//
//  SearchGitUserViewModel.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/31.
//

import Foundation
import Combine
import Alamofire

class SearchGitUserViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    var requestGitName = ""
    @Published var responseGitName = String()
    @Published var responseMessage = String()

    init() {
        print(#fileID, #function, #line, "")
        getGitUserName(rGitName: self.requestGitName)
    }
    
    func getGitUserName(rGitName: String) {
        print(#fileID, #function, #line, "")
        AF.request("\(GeneralAPI.baseURL)/users/github/\(rGitName)")
            .publishDecodable(type: SearchGitUserEntity.self)
            .compactMap { $0.value }
            .sink(receiveCompletion: { complete in
                print("데이터스트림 완료")
            }, receiveValue: { receivedValue in
                print("받은 값: \(receivedValue.description)")
                if (receivedValue.code == 1000) { // 성공
                    self.responseGitName = receivedValue.result.nickname
                } else { // 실패: 중복/통신실패
                    self.responseMessage = receivedValue.message
                }
                print("code: \(receivedValue.code) / message: \(receivedValue.message)")
            }).store(in: &subscription)
    }
    
//    func getGitUserName(requestGitName: String) -> String {
//        print(#fileID, #function, #line, "")
//        AF.request("\(GeneralAPI.baseURL)/users/github/\(requestGitName)")
//            .publishDecodable(type: SearchGitUserEntity.self)
//            .compactMap { $0.value }
//            .sink(receiveCompletion: { complete in
//                print("데이터스트림 완료")
//            }, receiveValue: { receivedValue in
//                print("받은 값: \(receivedValue.description)")
//                self.responseGitName = receivedValue.result.nickname
//            }).store(in: &subscription)
//
//        return responseGitName
//    }
}
