////
////  searchApi.swift
////  Gromit-client-iOS
////
////  Created by 이현진 on 2023/02/01.
////
//
//import Foundation
//import Moya
//
//enum searchApi{
//    case searchchallenges(String, String)
//}
//
//extension searchApi: TargetType{
//
//    public var baseURL: URL {
//        return URL(string: GeneralAPI.baseURL)!
//
//        var path: String {
//            switch self {
//            case .searchchallenges:
//                return "/challenges"
//            }
//        }
//        var method: Moya.Method {
//            switch self {
//            case .searchchallenges:
//                return .get
//            }
//        }
//
//        var task: Moya.Task {
//            <#code#>
//        }
//
//        var headers: [String : String]? {
//            <#code#>
//        }
//    }}
