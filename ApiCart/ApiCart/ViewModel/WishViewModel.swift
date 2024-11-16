//
//  WishViewModel.swift
//  ApiCart
//
//  Created by Dongik Song on 11/14/24.
//

import Foundation

@MainActor class WishViewModel: ObservableObject {
    @Published var wishList = [WishModel]()
    
    func fetchWishList() async {
        let randomNumber: Int = Int.random(in: 1...194)
        let url: String = "https://dummyjson.com/products/\(randomNumber)"
        guard let list: WishModel = await WishService().downLoadData(url: url) else { return }
        
        wishList = [list]
    }
}
