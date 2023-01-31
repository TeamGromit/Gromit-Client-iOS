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
    @Published var responseGitName = String()

    init() {
        print(#fileID, #function, #line, "")
        getGitUserName()
    }
    
//    func getGitUserName(name: String) {
//        print(#fileID, #function, #line, "")
//        AF.request("\(GeneralAPI.baseURL)/users/github/\(name)")
//            .publishDecodable(type: SearchGitUserEntity.self)
//            .compactMap { $0.value }
//            .sink(receiveCompletion: { complete in
//                print("데이터스트림 완료")
//            }, receiveValue: { (receivedValue: SearchGitUserEntity) in
//                print("받은 값: \(receivedValue)")
//                self.gitName = receivedValue.result.githubNickname
//            }).store(in: &subscription)
//    }
    
    func getGitUserName() {
        print(#fileID, #function, #line, "")
        AF.request("\(GeneralAPI.baseURL)/users/github/juhee-dev")
            .publishDecodable(type: SearchGitUserEntity.self)
            .compactMap { $0.value }
            .sink(receiveCompletion: { complete in
                print("데이터스트림 완료")
            }, receiveValue: { receivedValue in
                print("받은 값: \(receivedValue)")
                self.responseGitName = receivedValue.result.githubNickname
            }).store(in: &subscription)
    }
}
