//
//  MainView.swift
//  ToDoList
//
//  Created by Dongik Song on 10/21/24.
//



import SwiftUI
import SwiftData

struct MainView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var isShowing = false
    @State private var isEditing = false
    @State private var title = ""
    @State private var tempoList: TodoModel?
    @State private var searchText = ""
    
    @Query(sort: \TodoModel.id) private var todoLists: [TodoModel]
    
    var filteredList: [TodoModel] {
        guard !searchText.isEmpty else { return todoLists }
        return todoLists.filter { $0.title.localizedCaseInsensitiveContains(searchText)}
    }
    
    var body: some View {
        NavigationStack {
            NavigationView {
                // MARK: -  List
                List(filteredList, id: \.self) { list in
                    NavigationLink(value: list) {
                        CellView(isOn: list.isCompleted,
                                 title: "\(list.title)")
                        .swipeActions(edge: .trailing) {
                            Button(action: {
                                modelContext.delete(list)
                            }) {
                                Image(systemName: "trash")
                            }
                        }
                        .tint(.red)
                        .swipeActions(edge: .leading) {
                            Button("edit",
                                   systemImage: "pencil") {
                                isEditing.toggle()
                                tempoList = list
                            }
                        }
                        .tint(.blue)
                        .alert("TodoList 수정",
                               isPresented: $isEditing) {
                            TextField("수정", text: $title)
                            Button("OK",
                                   role: .cancel) {
                                if let currentTitle = tempoList?.title {
                                    modifyList(currentTitle: currentTitle, modifiedTitle: title)
                                }
                            }
                            Button("Cancel", role: .destructive){
                                title = ""
                            }
                        }
                    } //: NavigationLink
                } //: List
            } //: NavigationView
            .navigationTitle("ToDoList")
            .navigationDestination(for: TodoModel.self) { list in
                DetailView(title: list.title)
            }
            .toolbar {
                ToolbarItem(id: "add",
                            placement: .navigationBarTrailing) {
                    Button("add",
                           systemImage: "plus.app") {
                        isShowing.toggle()
                    }
                           .alert("TodoList 추가",
                                  isPresented: $isShowing) {
                               
                               TextField("TodoList 추가", text: $title)
                               Button("OK",
                                      role: .cancel) {
                                   addList()
                               }
                               Button("Cancel", role: .destructive){
                                   title = ""
                               }
                           }
                    
                }
                ToolbarItem(id: "DeleteAll",
                            placement: .navigationBarLeading) {
                    Button("DeleteAll",
                           systemImage: "folder.badge.minus") {
                        do {
                            try modelContext.delete(model: TodoModel.self)
                        } catch {
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText,
                    placement: .sidebar,
                    prompt: "Todo Search")
    }
    // MARK: - Functions
    func addList() {
        let id: Int = todoLists.count
        let todoModel = TodoModel(id: chkId(id), title: title, isCompleted: false)
        modelContext.insert(todoModel)
        title = ""
    }
    
    func chkId(_ currentId: Int) -> Int {
        var id = currentId
        if let maxId = todoLists.map({ $0.id }).max() {
            id = maxId + 1
        }
        return id
    }
    
    func modifyList(currentTitle: String, modifiedTitle: String) {
        let i = todoLists.firstIndex { list in
            list.title == currentTitle
        }
        todoLists[i!].title = modifiedTitle
        title = ""
    }
}

#Preview {
    MainView()
        .modelContainer(for: TodoModel.self)
}

