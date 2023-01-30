//
//  LoginWithAppleRequest.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/30.
//

import Foundation

struct LoginWithAppleRequest: Codable {
    var token: String
    
    init(_ token: String) {
        self.token = token
    }
}
