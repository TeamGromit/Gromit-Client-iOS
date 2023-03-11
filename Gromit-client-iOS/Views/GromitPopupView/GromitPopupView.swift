//
//  GromitPopupView.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/03/11.
//

import SwiftUI

struct GromitPopupView<Content: View>: View {
    
    enum ButtonType {
        case oneButton, twoButton
    }
    
    
    var buttonType: ButtonType = .twoButton
    
    var okDelegate: (() -> Void)?
    var cancleDelegate: (() -> Void)?
    
    @ViewBuilder var content: Content
    
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
                    content
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
        GromitPopupView<GitProfileView>(buttonType: .twoButton, content: {
            GitProfileView(userName: "kts", urlString: "")
        })
    }
}
