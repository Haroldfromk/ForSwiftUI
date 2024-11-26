//
//  MainView.swift
//  BookStore
//
//  Created by Dongik Song on 11/25/24.
//

import SwiftUI

struct MainView: View {
    @State var searchText: String = ""
    @EnvironmentObject var markViewModel: MarkViewModel
    @EnvironmentObject var apiViewModel: APIViewModel
    @EnvironmentObject var recentViewModel: RecentViewModel

    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("최근 본 책")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    ScrollView(.horizontal) {
                        let gridItem = [GridItem(.fixed(120))]
                        LazyHGrid(rows: gridItem) {
                            ForEach(recentViewModel.recentBooks) { book in
                                GridView(imageURL: book.thumbnail ?? "", title: book.title ?? "")
                            }
                        }
                    }
                    .scrollIndicators(.automatic)
                    .frame(height: UIScreen.main.bounds.width * 0.43)
                }
                .padding(.horizontal, 20)
                VStack(alignment: .leading) {
                    Text("검색 결과")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    List {
                        ForEach(apiViewModel.books) { book in
                            NavigationLink {
                                DetailView(isFromMain: true, book: book)
                                    .environmentObject(markViewModel)
                                    .environmentObject(recentViewModel)
                            } label: {
                                ResultListCell(title: book.title,
                                               author: book.authors.joined(separator: ", "),
                                               price: book.price)
                            }
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
            searchText = ""
        }
    }
}
