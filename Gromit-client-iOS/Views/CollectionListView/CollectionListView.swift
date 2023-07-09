//
//  CollectionListView.swift
//  Gromit-client-iOS
//
//  Created by juhee on 2023/01/27.
//

import SwiftUI

struct CollectionListView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject var collectionListViewModel = CollectionListViewModel()

    init() {
        print("CollectionListView init!")
    }
    var body: some View {
        ZStack {
            VStack {
                CollectionTitle()
                
                CollectionCount()
                
                CollectionCell()
            }
        }
        .environmentObject(collectionListViewModel)
        .onReceive(collectionListViewModel.$outputEvent) { event in
            if let event = event {
                receiveViewModelEvent(event)
            }
        }.onAppear {
            collectionListViewModel.requestCollections()
        }
    }
}

extension CollectionListView {
    private func receiveViewModelEvent(_ event: CollectionListViewModel.OutputEvent) {
        switch event {
        case .requestError:
            break
        case .loading:
            coordinator.startLoading()
        case .loaded:
            coordinator.stopLoading()

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
    @EnvironmentObject private var collectionListViewModel: CollectionListViewModel

    
    var body: some View {
        HStack {
            Spacer()
            Text("\(String(collectionListViewModel.collectionCharacters.count)) / \(String(collectionListViewModel.collectionCharacterCount))")
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
    @State private var containerWidth: CGFloat = 5
    @EnvironmentObject private var collectionListViewModel: CollectionListViewModel

//    let myArray = Array(1...numOfMyCharacters).map { "목록 \($0)"}
//    let unKnownArray = Array(2...10).map { "목록 \($0)"}
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
                
                ForEach(collectionListViewModel.collectionCharacters) { character in
                    VStack {
                        ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color("green300"))
                            //.frame(width: containerWidth, height: containerWidth)
                            .frame(width: 100, height: 100)
                            .overlay(RoundedRectangle(cornerRadius: 30)
                                .stroke(Color("gray500")))
                            
                            URLImage(urlString: character.image)
                                .aspectRatio(contentMode: .fit)
//                                .frame(width: containerWidth - 10, height: containerWidth - 10)
                                .frame(width: 90, height: 90)
                                .cornerRadius(30)
                            
                        }
                        Text(character.name)
                            .font(.system(size: 16))
                    }
                }
                
                ForEach(collectionListViewModel.collectionCharacters.count..<collectionListViewModel.collectionCharacterCount, id: \.self) { i in
                    VStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color("gray500"))
                            .frame(width: 100, height: 100)

                        Text("???")
                            .font(.system(size: 16))
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}
