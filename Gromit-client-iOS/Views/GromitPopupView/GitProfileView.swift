//
//  GitProfileView.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/03/11.
//

import SwiftUI

struct GitProfileView: View {
    
    var userName: String
    var urlString: String
    
    var body: some View {
            VStack(spacing: 15) {
                URLImage(urlString: urlString)
                Text("\(userName)")
                    .fontWeight(.bold)
                
                Text("해당 유저가 맞습니까?")
                    .fontWeight(.bold)
            }
        
    }
}

struct GitProfileView_Previews: PreviewProvider {
    static var previews: some View {
        GitProfileView(userName: "kts", urlString: "https://avatars.githubusercontent.com/u/94947?v=4")
    }
}
