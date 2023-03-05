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
    let date: String
    let goal: String
    let headCount: String
    let maxHead: String
}

struct ParticipatingChallenge: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let goal: String
    let progress: String
    let headCount: String
    let maxHead: String
}

struct AllChallengeList {
    static let allChallengeList = [
        Challenge(title: "1일 1커밋 진짜 찐으로 하실 분!", date: "23/01/01", goal: "999", headCount: "2", maxHead: "6"),
        Challenge(title: "목표는 100커밋", date: "23/01/01", goal: "100", headCount: "10", maxHead: "20"),
        Challenge(title: "iOS 챌린지 하실분~~ 같이 열심히 해봐요", date: "23/01/01", goal: "200", headCount: "4", maxHead: "10"),
        Challenge(title: "제목1", date: "23/01/01", goal: "100", headCount: "1", maxHead: "6"),
        Challenge(title: "제목2", date: "23/01/01", goal: "100", headCount: "1", maxHead: "6"),
        Challenge(title: "제목3", date: "23/01/01", goal: "100", headCount: "1", maxHead: "6"),
        Challenge(title: "제목4", date: "23/01/01", goal: "100", headCount: "1", maxHead: "6"),
        Challenge(title: "제목5", date: "23/01/01", goal: "100", headCount: "1", maxHead: "6"),
        Challenge(title: "제목6", date: "23/01/01", goal: "100", headCount: "1", maxHead: "6"),
        Challenge(title: "제목7", date: "23/01/01", goal: "100", headCount: "1", maxHead: "6"),
    ]
}

struct ParticipatingList {
    static let participatingList = [
        ParticipatingChallenge(title: "20자이내로제목을작성해주세요감사합니다", date: "23/01/01", goal: "100", progress: "80", headCount: "1", maxHead: "6"),
        ParticipatingChallenge(title: "20자이내로제목을작성해주세요", date: "23/01/01", goal: "100", progress: "80", headCount: "1", maxHead: "6"),
        ParticipatingChallenge(title: "1일 10커밋", date: "23/01/01", goal: "100", progress: "80", headCount: "1", maxHead: "6"),
        ParticipatingChallenge(title: "같이 1일 1커밋 하실 분!", date: "23/01/01", goal: "100", progress: "80", headCount: "1", maxHead: "6"),
        ParticipatingChallenge(title: "20자이내로제목", date: "23/01/01", goal: "100", progress: "80", headCount: "1", maxHead: "6"),
        ParticipatingChallenge(title: "20자이내로", date: "23/01/01", goal: "100", progress: "80", headCount: "1", maxHead: "6"),
        ParticipatingChallenge(title: "20자이내로제목을작성해주세용가리", date: "23/01/01", goal: "100", progress: "80", headCount: "1", maxHead: "6"),
        ParticipatingChallenge(title: "20자이내로제목을작성해주삼", date: "23/01/01", goal: "100", progress: "80", headCount: "1", maxHead: "6"),
        ParticipatingChallenge(title: "20자이내로제목을작성해라", date: "23/01/01", goal: "100", progress: "80", headCount: "1", maxHead: "6"),
        ParticipatingChallenge(title: "20자이내로제목을작성해주어", date: "23/01/01", goal: "100", progress: "80", headCount: "1", maxHead: "6"),
    ]
}
