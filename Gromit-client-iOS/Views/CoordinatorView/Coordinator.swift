//
//  Coordinator.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/02/17.
//

import Foundation
import SwiftUI

// Page
// 일반 View
enum Page: String, Identifiable {
   case home
    var id: String {
        self.rawValue
    }
}

// Sheet
// Modal과 흡사
// 호출 뷰와 상속 관계가 아닌..?
enum Sheet: String, Identifiable {
    case test
    var id: String {
        self.rawValue
    }
}

// FullScreenCover
// Modal과 흡사 FullScreen으로 호출 View를 모두 덮는다.
// 호출 뷰와 상속 관계가 아닌..?
enum FullScreenCover: String, Identifiable {
    case collectionListView, challengeCreateView
    var id: String {
        self.rawValue
    }
}

// 객체의 변화를 감지하기 위해서는 ObservableObject 프로토콜을 채택해야한다.
class Coordinator: ObservableObject {
    
    // @Published @ObservableObject 프로토콜 준수해야 사용 가능
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    func push(page: Page) {
        self.path.append(page)
    }
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func present(fullScreenCover: FullScreenCover) {
        
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        if(path.isEmpty == false) {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .home:
            NavigationStack {
                CreationView()
            }
        }
    }

    
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .test:
            NavigationStack {
                CreationView()
            }
        }
    }
    
    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .challengeCreateView:
            NavigationStack {
                CreationView()
            }
        case .collectionListView:
            NavigationStack {
                CollectionListView()
            }
        }
        
    }
}
