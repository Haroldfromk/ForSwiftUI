//
//  TestWishViewModel.swift
//  ApiCart
//
//  Created by Dongik Song on 11/15/24.
//

import Foundation

@MainActor
class TestWishViewModel: ObservableObject {
    @Published var wishList = [WishModel]()

    init() {
        Task {
            await fetchWishList()
        }
    }

    func fetchWishList() async {
        let randomNumber: Int = Int.random(in: 1...194)
        let url: String = "https://dummyjson.com/products/\(randomNumber)"
        guard let list: WishModel = await WishService().downLoadData(url: url) else { return }

        wishList = [list]
    }
}
