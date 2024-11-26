//
//  SavedListView.swift
//  BookStore
//
//  Created by Dongik Song on 11/25/24.
//

import SwiftUI

struct MarkListView: View {
    @EnvironmentObject var viewModel: MarkViewModel
    @State var showAlert: Bool = false
    @State var alertState: AlertDelete = .isDelete
    @State var selectedBook: MarkedBookModel?
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.book) { book in
                        NavigationLink {
                            DetailView(isFromMain: false, markedBook: book)
                        } label: {
                            MarkListCell(imageURL: book.thumbnail,
                                         title: book.title,
                                         author: book.authors,
                                         price: book.price)
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                alertState = .isDelete
                                selectedBook = book
                                showAlert = true
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("담은 책")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        if !viewModel.book.isEmpty {
                            alertState = .isAlldelete
                        } else {
                            alertState = .isEmpty
                        }
                        showAlert = true
                    } label: {
                        Text("전체 삭제")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button {
                            viewModel.undoAction()
                        } label: {
                            Image(systemName: "arrow.uturn.backward")
                        }
                        .disabled(viewModel.modelContext.undoManager!.canUndo == false)
                        Button {
                            viewModel.redoAction()
                        } label: {
                            Image(systemName: "arrow.uturn.forward")
                        }
                        .disabled(viewModel.modelContext.undoManager!.canRedo == false)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                switch alertState {
                case .isDelete:
                    return Alert(title: Text("삭제하시겠습니까"),
                                 primaryButton: .destructive(Text("확인"),
                                                             action:
                                                                {
                        guard let book = selectedBook else { return }
                        viewModel.deleteMark(object: book)
                    }),
                                 secondaryButton: .cancel())
                case .isAlldelete:
                    return Alert(title: Text("전체 삭제하시겠습니까"),
                                 primaryButton: .destructive(Text("확인"),
                                                             action: {
                        viewModel.deleteAllMark()
                    }),
                                 secondaryButton: .cancel())
                case .isEmpty:
                    return Alert(title: Text("안내"), message: Text("담은 책이 없습니다."))
                }
            }
        }
        .onAppear {
            viewModel.fetchRequest()
        }
    }
    
    
}
