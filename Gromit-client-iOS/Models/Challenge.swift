//
//  Challenge.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/21.
//

import Foundation

struct Challenge {
    var title: String
    var date: String
    var goal: String
    var headCount: String
}

struct ChallengeList {
    static let challengeList = [
        Challenge(title: "제목", date: "23/01/01", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/02", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/03", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/04", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/05", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/06", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/07", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/08", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/09", goal: "100", headCount: "1"),
        Challenge(title: "제목", date: "23/01/10", goal: "100", headCount: "1"),
    ]
}
