//
//  Challenge.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/21.
//

import Foundation

struct Challenge: Identifiable {
    let id = UUID()
    let title: String
    let startDate: String
    let endDate: String
    let goal: Int
    let recuits: Int
    let currentMemberNum: Int
    let isPassword: Bool
    let password: String?
}

//struct ParticipatingChallenge: Identifiable {
//    let id = UUID()
//    let title: String
//    let date: String
//    let goal: String
//    let progress: String
//    let headCount: String
//    let maxHead: String
//}

struct ChallengeList {
    static let allChallengeList = [
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
    ]
    
    static let participatingList = [
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
        Challenge(title: "1일 1커밋 하실분!", startDate: "2023-05-05", endDate: "2023-12-31", goal: 100, recuits: 5, currentMemberNum: 1, isPassword: false, password: ""),
    ]
}
