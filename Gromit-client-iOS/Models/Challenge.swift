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

struct ChallengeList {
    static let challengeList = [
        Challenge(title: "제목", date: "23/01/01", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/01", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/01", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/01", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/01", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/01", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/01", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/01", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/01", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/01", goal: "100", headCount: "1"),
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
