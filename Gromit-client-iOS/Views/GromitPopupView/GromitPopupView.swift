//
//  GromitPopupView.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/03/11.
//

import SwiftUI
// Push 테스트를 위함
struct GromitPopupView: View {
    
    enum ButtonType {
        case oneButton, twoButton
    }
    
    enum PopupType {
        case gitProfileView, message
    }
    
    var popupType: PopupType
    var buttonType: ButtonType = .oneButton
    
    var userName: String = ""
    var urlString: String = ""
    var title: String = ""
    var message: String = ""
    
    var okDelegate: (() -> Void)?
    var cancleDelegate: (() -> Void)?
    
    
    
    var body: some View {
        ZStack {
            Color(.darkGray)
                .opacity(0.5)
                .ignoresSafeArea()
            ZStack {
                Rectangle()
                    .frame(width: 300, height: 300)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                VStack(spacing: 30) {
                    switch popupType {
                    case .gitProfileView:
                        GitProfileView(userName: userName, urlString: urlString)
                    case .message:
                        MessageView(title: title, message: message)
                    }
                    HStack(spacing: 25) {
                        switch buttonType {
                        case .oneButton:
                            Button("OK") {
                                if let okDelegate = okDelegate {
                                    okDelegate()
                                }
                            }.buttonStyle(InputButtonStyle(width: 250, height: 50))
                            
                        case .twoButton:
                            Spacer(minLength: 10)
                            Button("OK") {
                                if let okDelegate = okDelegate {
                                    okDelegate()
                                }
                            }.buttonStyle(InputButtonStyle(width: 120, height: 50))
                                .frame(width: 120, height: 50)
                            Button("Cancle") {
                                if let cancleDelegate = cancleDelegate {
                                    cancleDelegate()
                                }
                            }.buttonStyle(InputButtonStyle(width: 125, height: 50))
                                .frame(width: 120, height: 50)
                            Spacer(minLength: 10)
                        }
                    }
                }
            }.offset(y: -80)
        }
    }
    
 
}

struct GromitPopupView_Previews: PreviewProvider {
    static var previews: some View {
        GromitPopupView(popupType: .message)
    }
}

//
//struct GromitPopupView<Content: View>: View {
//
//    enum ButtonType {
//        case oneButton, twoButton
//    }
//
//    enum PopupType {
//        case gitProfileView, message
//    }
//
//    var popupType:
//    var buttonType: ButtonType = .twoButton
//
//    var okDelegate: (() -> Void)?
//    var cancleDelegate: (() -> Void)?
//
//    @ViewBuilder var content: Content
//
//    var body: some View {
//        ZStack {
//            Color(.darkGray)
//                .opacity(0.5)
//                .ignoresSafeArea()
//            ZStack {
//                Rectangle()
//                    .frame(width: 300, height: 300)
//                    .foregroundColor(.white)
//                    .cornerRadius(30)
//                VStack(spacing: 30) {
//                    content
//                    HStack(spacing: 25) {
//                        switch buttonType {
//                        case .oneButton:
//                            Button("OK") {
//                                if let okDelegate = okDelegate {
//                                    okDelegate()
//                                }
//                            }.buttonStyle(InputButtonStyle(width: 250, height: 50))
//
//                        case .twoButton:
//                            Spacer(minLength: 10)
//                            Button("OK") {
//                                if let okDelegate = okDelegate {
//                                    okDelegate()
//                                }
//                            }.buttonStyle(InputButtonStyle(width: 120, height: 50))
//                                .frame(width: 120, height: 50)
//
//                            Button("Cancle") {
//                                if let cancleDelegate = cancleDelegate {
//                                    cancleDelegate()
//                                }
//                            }.buttonStyle(InputButtonStyle(width: 125, height: 50))
//                                .frame(width: 120, height: 50)
//                            Spacer(minLength: 10)
//                        }
//                    }
//                }
//            }.offset(y: -80)
//        }
//    }
//}
