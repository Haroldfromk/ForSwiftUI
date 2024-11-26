//
//  GridView.swift
//  BookStore
//
//  Created by Dongik Song on 11/26/24.
//

import SwiftUI

struct GridView: View {
    @State var imageURL: String = ""
    @State var title: String = ""
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "photo.artframe")
            }
            .frame(width: 120, height: 120)
            Text(title)
                .font(.system(size: 15))
        }
        .border(Color.black, width: 1)
        .frame(width: 120, height: 20)
    }
}

#Preview {
    GridView(imageURL: "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6520493%3Ftimestamp%3D20240806155416", title: "테스트")
}
