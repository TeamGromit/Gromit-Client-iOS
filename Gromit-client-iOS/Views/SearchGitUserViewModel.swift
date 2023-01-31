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
    
    func getGitUserName() {
        print(#fileID, #function, #line, "")
        AF.request("\(GeneralAPI.baseURL)/users/github/juhee-dev")
            .publishDecodable(type: SearchGitUserEntity.self)
            .compactMap { $0.value }
            .sink(receiveCompletion: { complete in
                print("데이터스트림 완료")
            }, receiveValue: { receivedValue in
                print("받은 값: \(receivedValue.description)")
                self.responseGitName = receivedValue.result.nickname
            }).store(in: &subscription)
    }
}
