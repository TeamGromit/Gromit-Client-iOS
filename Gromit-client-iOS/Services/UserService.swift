//
//  SearchGitUserService.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/30.
//

import Foundation
import Moya

enum UserService {
    case searchGitUser(param: String)
}

extension UserService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
            case .searchGitUser:
                return "/users/github"
        }
    }
          
    var method: Moya.Method {
        switch self {
        case .searchGitUser:
            return .get
        }
    }
          
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
          
    var task: Task {
        switch self {
        case .searchGitUser(let param):
            return .requestParameters(parameters: ["githubNickname" : param], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
