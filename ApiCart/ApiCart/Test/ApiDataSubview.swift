//
//  ApiDataSubview.swift
//  ApiCart
//
//  Created by Dongik Song on 11/15/24.
//

import SwiftUI

struct ApiDataSubview: View {
    @ObservedObject var testWishViewModel = TestWishViewModel()
    @ObservedObject var cartViewModel: CartViewModel

    var body: some View {
        VStack {
            Text("API 조회 결과 - ObservedObject")
                .font(.headline)

            if let item = testWishViewModel.wishList.first {
                HStack {
                    Text(item.title)
                    Spacer()
                    Button("담기") {
                        cartViewModel.addCart(model: item)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(10)
            }

            Button("API 조회") {
                Task {
                    await testWishViewModel.fetchWishList()
                }
            }
            .padding()
        }
   
    }
}
