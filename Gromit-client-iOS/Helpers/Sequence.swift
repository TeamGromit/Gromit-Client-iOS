//
//  Sequence.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/07/08.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
