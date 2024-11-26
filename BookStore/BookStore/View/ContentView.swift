//
//  ContentView.swift
//  BookStore
//
//  Created by Dongik Song on 11/25/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var apiViewModel = APIViewModel()
    @StateObject var markViewModel = MarkViewModel()
    @StateObject var recentViewModel = RecentViewModel()
    
    var body: some View {
        TabView {
            Tab("검색", systemImage: "magnifyingglass") {
                MainView()
                    .environmentObject(apiViewModel)
                    .environmentObject(markViewModel)
                    .environmentObject(recentViewModel)
            }
            Tab("담은 책 리스트", systemImage: "list.bullet.clipboard") {
                MarkListView()
                    .environmentObject(markViewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
