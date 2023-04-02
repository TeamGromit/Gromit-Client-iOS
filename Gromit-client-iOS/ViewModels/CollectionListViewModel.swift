//
//  CollectionViewModel.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/04/01.
//

import Foundation
import Alamofire

class CollectionListViewModel: ObservableObject {
    
    enum OutputEvent {
        case requestError
    }
    
    @Published var outputEvent: OutputEvent? = nil
    @Published var isLoading: Bool = false
    @Published var collectionCharacters: [CollectionCharacter] = []
    
    init() {
        print("CollectionListViewModel")
        requestCollections()
    }
    
    func requestCollections() {
        isLoading = true
        
        guard let token = AppDataService.shared.getData(appData: .accessToken) else {
            print("Guard Error token is nil")
            isLoading = false
            return
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-AUTH-TOKEN": token
        ]
        
        NetworkingClinet.shared.request(serviceURL: .requestCollections, httpMethod: .get, headers: headers, type: ResponseMessage<[CollectionResult]>.self, completion: {
            responseData, error in
            if let error = error {
                self.outputEvent = .requestError
                self.isLoading = false
            } else {
                if let responseData = responseData, let responseMessage = responseData.1, let code = responseMessage.code {
                    if(code == 1000) {
                        if let responseResults = responseMessage.result{
                            self.collectionCharacters = responseResults.map{ element in
                                return CollectionCharacter(name: element.name ?? "", image: element.img ?? "")
                            }
                        }
                        self.isLoading = false
                    }
                }
            }
        })
        
    }
    
    
    
    
    
}
