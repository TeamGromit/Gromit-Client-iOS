//
//  LoginServices.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/30.
//

import Foundation
import Moya

enum LoginServices {
    case loginWithApple(param: LoginWithAppleRequest)
}

extension LoginServices: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
            case .loginWithApple:
                return "/login/apple"
        }
    }
          
    var method: Moya.Method {
        switch self {
        case .loginWithApple:
            return .post
        }
    }
          
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
          
    var task: Task {
        switch self {
        case .loginWithApple(let param):
            return .requestJSONEncodable(param)
        }
    }

    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
