//
//  GitUserNameView.swift
//  Gromit-client-iOS
//
//  Created by julia on 2023/01/23.
//

import SwiftUI

struct SearchGitUserView: View {
    @State private var userName = ""    // State
    @FocusState private var userNameIsFocused: Bool
    
    var body: some View {
        VStack {
            Text("GitHub User 이름을 입력해주세요.")
            
            TextField("User Name", text: $userName)
                .focused($userNameIsFocused)
                .frame(width: 200, height: 100, alignment: .center)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            userNameIsFocused = false
                        }
                    }
                }
        }

    }
}

struct SearchGitUserView_Previews: PreviewProvider {
    static var previews: some View {
        SearchGitUserView()
    }
}
