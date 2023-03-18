//
//  NavigationBarView.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/03/18.
//

import SwiftUI

struct NavigationBarView: View {
    
    @State var isActiveLeftButton: Bool
    @State var isActiveRightButton: Bool
    
    var title: String = ""
    var leftButtonTitleText: String?
    var rightButtonTitleText: String?
    
    var leftButtonTitleImage: Image?
    var rightButtonTitleImage: Image?
    
    
    
    var leftButtonTapped: (() -> Void)?
    var rightButtonTapped: (() -> Void)?
        
    init(isActiveLeftButton: Bool, isActiveRightButton: Bool, title: String? = nil, leftButtonTitle: String? = nil, rightButtonTitle: String? = nil, leftButtonImage: Image? = nil, rightButtonImage: Image? = nil, leftButtonTapped: (() -> Void)? = nil, rightButtonTapped: (() -> Void)? = nil) {
        self.isActiveRightButton = isActiveRightButton
        self.isActiveLeftButton = isActiveLeftButton
        
        if let title = title {
            self.title = title
        }
        
        if let leftButtonTitle = leftButtonTitle {
            self.leftButtonTitleText = leftButtonTitle
        }
        
        if let rightButtonTitle = rightButtonTitle {
            self.rightButtonTitleText = rightButtonTitle
        }
        
        if let leftButtonTitleImage = leftButtonTitleImage {
            self.leftButtonTitleImage = leftButtonTitleImage
        }
        
        if let rightButtonTitleImage = rightButtonTitleImage {
            self.rightButtonTitleImage = rightButtonTitleImage
        }
        
        if let leftButtonTapped = leftButtonTapped {
            self.leftButtonTapped = leftButtonTapped
        }
        
        if let rightButtonTapped = rightButtonTapped {
            self.rightButtonTapped = rightButtonTapped
        }
    }
    var body: some View {
        HStack {
            Spacer()
            
            if(isActiveLeftButton) {
                Button() {
                    if let leftButtonTapped = leftButtonTapped {
                        leftButtonTapped()
                    }
                } label: {
                    if let leftButtonTitleText = leftButtonTitleText {
                        Text(leftButtonTitleText)
                    }
                    
                    if let leftButtonTitleImage = leftButtonTitleImage {
                        leftButtonTitleImage
                    }
                }
                .modifier(NavigationBarButtonModifer())
            } else {
                Spacer(minLength: 100)
            }
          
            
            Spacer(minLength: 40)
            
            Text(title)
              
            Spacer(minLength: 40)
            
            if(isActiveRightButton) {
                Button() {
                    if let rightButtonTapped = rightButtonTapped {
                        rightButtonTapped()
                    }
                } label: {
                    if let rightButtonTitleText = rightButtonTitleText {
                        Text(rightButtonTitleText)
                    }
                    
                    if let rightButtonTitleImage = rightButtonTitleImage {
                        rightButtonTitleImage
                    }
                }.modifier(NavigationBarButtonModifer())
            } else {
                Spacer(minLength: 100)
            }
         
           
            Spacer()
        }
    }
    
    @discardableResult
    func setNavigationTitle(leftButtonTtitle: String? = nil, rightButtonTitle: String? = nil, navigationTitle: String? = nil) -> some View {
        
        return self
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(isActiveLeftButton: true, isActiveRightButton: true, title: "참여 챌린지", leftButtonTitle: "", rightButtonTitle: "")
    }
}


struct NavigationBarButtonModifer: ViewModifier {
    
    
    func body(content: Content) -> some View {
            return content.frame(width: 100, height: 40)
                .font(.system(size: 18))
                .foregroundColor(Color(.gray))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color(.gray))
                    )
      
    }
}


struct NavigationBarTitleModifer: ViewModifier {
    
    func body(content: Content) -> some View {
        return content
            .fontWeight(.bold)
            .font(.system(size: 18))
    }
}
