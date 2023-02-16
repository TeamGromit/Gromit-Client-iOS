//
//  ViewRouter.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/02/16.
//

import Foundation
import Combine
import SwiftUI

class ViewRouter : ObservableObject{
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: String = "participatingListView" {
        didSet{
            objectWillChange.send(self)
        }
    }
}
