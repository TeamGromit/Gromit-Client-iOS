//
//  GitMessageView.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/03/11.
//

import SwiftUI

struct MessageView: View {
    var title: String
    var message: String
    
    var body: some View {
            VStack(spacing: 15) {
                Text("\(title)")
                    .fontWeight(.bold)
                    .font(.title2)
                
                Text("\(message)")
                    .fontWeight(.bold)
                
            }
        
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(title: "Title", message: "Message")
    }
}
