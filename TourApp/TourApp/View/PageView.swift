//
//  PageView.swift
//  TourApp
//
//  Created by Dongik Song on 11/7/24.
//

import SwiftUI

struct PageView: View {
    
    var lists = [ResList]()
    
    @State private var currentPage: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            TabView(selection: $currentPage.animation()) {
                ForEach(lists.indices, id: \.self) { index in
                        VStack {
                            AsyncImage(url: URL(string: lists[index].imageURL)) { image in
                                image
                                    .resizable()
                                    .frame(maxWidth: 150, maxHeight: 150)
                            } placeholder: {
                                Image(systemName: "photo")
                            }
                            Link(destination: URL(string: lists[index].shopURL)!) { Text(lists[index].shopTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.blue)
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<lists.count, id: \.self) { index in
                        Circle()
                            .frame(width: index == currentPage ? 12 : 8, height: index == currentPage ? 16 : 10)
                            .foregroundStyle(.blue.opacity(index == currentPage ? 1 : 0.5))
                    }
                }
                .padding(.horizontal)
                .scrollTargetLayout()
            }
            .background(.clear, in: RoundedRectangle(cornerRadius: 30))
            .frame(width: 60)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: Binding($currentPage), anchor: .center)
            .allowsTightening(false)
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    PageView()
}
