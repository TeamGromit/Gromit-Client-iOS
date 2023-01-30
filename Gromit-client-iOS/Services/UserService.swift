//
//  SearchGitUserService.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/30.
//

//import Foundation
//import Moya
//
//enum UserService {
//    case searchGitUser(param: String)
//}
//
//extension UserService: TargetType {
//    public var baseURL: URL {
//        return URL(string: GeneralAPI.baseURL)!
//    }
//
//    var path: String {
//        switch self {
//            case .searchGitUser:
//                return "/users/github"
//        }
//    }
//
//    var method: Moya.Method {
//        switch self {
//        case .searchGitUser:
//            return .get
//        }
//    }
//
//    var sampleData: Data {
//        return "@@".data(using: .utf8)!
//    }
//
//    var task: Task {
//        switch self {
//        case .searchGitUser(let param):
//            return .requestParameters(parameters: ["githubNickname" : param], encoding: URLEncoding.queryString)
//        }
//    }
//
//    var headers: [String: String]? {
//        switch self {
//        default:
//            return ["Content-Type": "application/json"]
//        }
//    }
//}

import Foundation

class UserService: ObservableObject {
    static let shared = UserService()
    private init() {}
    @Published var gitName = ""
    
    func getGitUser(name: String) {
        guard let url = URL(string: "\(GeneralAPI.baseURL)/users/github/\(name)") else { return }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self.gitName = ""
                return
            }
            guard let data = data else { return }
            do {
                let apiResponse = try JSONDecoder().decode(SearchGitUserEntity.self, from: data)
                DispatchQueue.main.async {
                    self.gitName = apiResponse.result.githubNickname
                    print("Services-gitName: \(self.gitName)")
                }
            } catch(let err) {
                print(err.localizedDescription)
            }
        }
        task.resume()
    }
}
