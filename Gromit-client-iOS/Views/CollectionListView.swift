//
//  CollectionListView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/27.
//

import SwiftUI

var numOfMyCharacters = 2
var numOfAllCharacters = 10

struct CollectionListView: View {
    var body: some View {
        VStack {
            CollectionTitle()
            
            CollectionCount()
            
            CollectionCell()
        }
    }
}

struct CollectionListView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionListView()
    }
}

struct CollectionTitle: View {
    var body: some View {
        VStack {
            Text("")
            Text("")
            Text("")
            
            HStack {
                Text("컬렉션")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                Spacer()
            }
            
        }
    }
}

struct CollectionCount: View {
    var body: some View {
        HStack {
            Spacer()
            Text("\(String(numOfMyCharacters)) / \(String(numOfAllCharacters))")
                .font(.system(size: 16))
                .foregroundColor(Color(.gray))
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color(.gray))
                )
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
    }
}

struct CollectionCell: View {
    @State private var containerWidth: CGFloat = 0
    let myArray = Array(1...numOfMyCharacters).map { "목록 \($0)"}
    let unKnownArray = Array(numOfMyCharacters...numOfAllCharacters).map { "목록 \($0)"}
    let columns = [
            GridItem(.adaptive(minimum: 100))
        ]
    
    var body: some View {
        ScrollView {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.clear)
                    .onAppear {
                        containerWidth = geo.size.width / 3 - 10
                    }
            }
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(myArray, id: \.self) { i in
                    VStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color("green300"))
                            .frame(width: containerWidth, height: containerWidth)
                            .overlay(RoundedRectangle(cornerRadius: 30)
                                .stroke(Color("gray500")))
                            
                        Text("캐릭터 이름")
                            .font(.system(size: 16))
                    }
                }
                ForEach(unKnownArray, id: \.self) { i in
                    VStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color("gray500"))
                            .frame(width: containerWidth, height: containerWidth)
                       
                        Text("???")
                            .font(.system(size: 16))
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}
