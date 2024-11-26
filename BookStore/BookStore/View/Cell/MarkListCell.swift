//
//  MarkListCell.swift
//  BookStore
//
//  Created by Dongik Song on 11/26/24.
//

import SwiftUI

struct MarkListCell: View {
    @State var imageURL: String = ""
    @State var title: String = "title"
    @State var author: String = "author"
    @State var price: Int = 0
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "photo.artframe")
            }
            .frame(width: 50, height: 50)
            Spacer()
            Text(title)
                .font(.system(size: 13))
            Spacer()
            Text(author)
                .font(.system(size: 11))
            Spacer()
            Text(price.toString())
                .font(.system(size: 13))
        }
    }
}

#Preview {
    MarkListCell(imageURL: "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038",
                 title: "미움받을 용기",
                 author: "기시미 이치로, 고가 후미타케",
                 price: 14900)
}
