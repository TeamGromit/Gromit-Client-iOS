//
//  CollectionCharacter.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/04/01.
//

import Foundation
import SwiftUI

struct CollectionCharacter: Identifiable, Hashable {
    var name: String
    var image: String
    var id: String {
        self.name
    }
}

