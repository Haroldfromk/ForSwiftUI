//
//  DetailView.swift
//  BookStore
//
//  Created by Dongik Song on 11/26/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var markViewModel: MarkViewModel
    @EnvironmentObject var recentViewModel: RecentViewModel
    @State var showAlert: Bool = false
    @State var activeAlert: AlertType = .isDuplicated
    
    var isFromMain: Bool
    var book: Document?
    var markedBook: MarkedBookModel?
    
    var title: String = ""
    var authors: String = ""
    var imageURL: String = ""
    var price: Int = 0
    var contents: String = ""
    
    init(isFromMain: Bool, book: Document? = nil, markedBook: MarkedBookModel? = nil) {
            self.isFromMain = isFromMain
            if let book = book, isFromMain {
                self.book = book
                title = book.title
                authors = book.authors.joined(separator: ", ")
                imageURL = book.thumbnail
                price = book.price
                contents = book.contents
            } else if let markedBook = markedBook {
                self.markedBook = markedBook
                title = markedBook.title
                authors = markedBook.authors
                imageURL = markedBook.thumbnail
                price = markedBook.price
                contents = markedBook.contents
            }
        }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 25))
                .fontWeight(.bold)
            Spacer()
            Text(authors)
                .font(.system(size: 15))
            Spacer()
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "photo.artframe")
            }
            .frame(height: UIScreen.main.bounds.height * 0.4)
            Spacer()
            Text(price.toString())
            Spacer()
            ScrollView {
                Text(contents)
            }
            .padding(.horizontal, 25)
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("닫기")
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                        .frame(width: isFromMain ? UIScreen.main.bounds.width * 0.25 : UIScreen.main.bounds.width * 0.9,
                               height: UIScreen.main.bounds.height * 0.05)
                                                .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                    .foregroundStyle(.gray)
                                                    .opacity(0.5))
                }
                if isFromMain {
                    Button {
                        if let book = book {
                            if markViewModel.checkDuplicate(object: book) {
                                self.activeAlert = .isDuplicated
                            } else {
                                markViewModel.addMark(object: book)
                                self.activeAlert = .isAdded
                            }
                        }
                        self.showAlert = true
                    } label: {
                        Text("담기")
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                            .frame(width: UIScreen.main.bounds.width * 0.65, height: UIScreen.main.bounds.height * 0.05)
                                                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                        .foregroundStyle(.green)
                                                        .opacity(0.5))
                    }
                    .alert(isPresented: $showAlert) {
                        switch activeAlert {
                        case .isDuplicated:
                            return Alert(title: Text("중복 확인"), message: Text("이미 담긴 책입니다."))
                        case .isAdded:
                            return Alert(title: Text("추가 완료"), message: Text("책이 리스트에 추가되었습니다."))
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            if let book = book, !recentViewModel.checkDuplicate(object: book) {
                recentViewModel.addRecent(object: book)
            }
        }
    }
}
