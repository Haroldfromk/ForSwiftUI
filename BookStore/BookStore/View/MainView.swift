//
//  MainView.swift
//  BookStore
//
//  Created by Dongik Song on 11/25/24.
//

import SwiftUI

struct MainView: View {
    @State var searchText: String = ""
    @EnvironmentObject var apiViewModel: APIViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("최근 본 책")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    HStack {
                        ScrollView {
//                            LazyHGrid(rows: [GridItem]) {
//                                
//                            }
                        }
                    }
                    .frame(height: UIScreen.main.bounds.width * 0.35)
                }
                .padding(.horizontal, 20)
                VStack(alignment: .leading) {
                    Text("검색 결과")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    List {
                        ForEach(apiViewModel.books) { book in
                           ResultListCell(title: book.title,
                                          author: book.authors.joined(separator: " "),
                                          price: book.price)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            Task {
                await  apiViewModel.request(searchText: searchText)
            }
        }
        .onDisappear {
            apiViewModel.books.removeAll()
        }
    }
}
