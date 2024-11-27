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
    @State var isDelete: Bool = false
    
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
                                NavigationLink {
                                    let item = convert(object: book)
                                    DetailView(isFromMain: false, markedBook: item)
                                        .environmentObject(markViewModel)
                                        .environmentObject(recentViewModel)
                                } label: {
                                    GridView(imageURL: book.thumbnail ?? "", title: book.title ?? "")
                                }
                            }
                        }
                    }
                    .scrollIndicators(.automatic)
                    .frame(height: UIScreen.main.bounds.width * 0.43)
                    HStack {
                        Spacer()
                        if !recentViewModel.recentBooks.isEmpty {
                            Button {
                                isDelete = true
                            } label: {
                                Text("최근 본 내역 삭제")
                                    .foregroundStyle(.red)
                            }
                            .alert(isPresented: $isDelete) {
                                Alert(title: Text("삭제"), message: Text("최근 본 내역을 삭제하시겠습니까?"), primaryButton: .destructive(Text("삭제")) {
                                    recentViewModel.deleteAll()
                                }, secondaryButton: .cancel(Text("취소")))
                            }
                        }
                    }
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
        .onChange(of: searchText) { _, _ in
            if searchText.isEmpty {
                apiViewModel.books.removeAll()
            }
        }
        .onDisappear {
            apiViewModel.books.removeAll()
            searchText = ""
        }
    }
    // Helper
    func convert(object: RecentBook) -> MarkedBookModel {
        let item = MarkedBookModel(
            authors: object.authors ?? "",
            contents: object.contents ?? "",
            price: Int(object.price),
            publisher: object.publisher ?? "",
            status: object.status ?? "",
            thumbnail: object.thumbnail ?? "",
            title: object.title ?? "",
            url: object.url ?? "")
        return item
    }
}
