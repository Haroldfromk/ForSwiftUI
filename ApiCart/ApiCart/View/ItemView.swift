//
//  ItemView.swift
//  ApiCart
//
//  Created by Dongik Song on 11/14/24.
//

import SwiftUI

// MARK: - Observed, StateObject 사용
//struct ItemView: View {
//    
//    @ObservedObject var wishViewModel: WishViewModel
//    @StateObject var cartViewModel: CartViewModel
//    @StateObject var sdCartViewModel: SDCartViewModel
//    
//    @State var isDuplicated = false
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            AsyncImage(url: URL(string: wishViewModel.wishList.first?.thumbnail ?? "")) { image in
//                image
//                    .resizable()
//                    .scaledToFill()
//                    
//            } placeholder: {
//                Image(systemName: "photo")
//                    .resizable()
//            }
//            .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.4)
//            Text(wishViewModel.wishList.first?.title ?? "")
//            Text(wishViewModel.wishList.first?.description ?? "")
//                .padding(.horizontal, 20)
//            HStack {
//                Spacer()
//                Text(wishViewModel.wishList.first?.price.dollarAdd() ?? "$")
//            }
//            .padding(.horizontal, 25)
//            HStack {
//                Button {
//                    Task {
//                        await wishViewModel.fetchWishList()
//                    }
//                } label: {
//                    Text("다음")
//                        .fontWeight(.bold)
//                        .font(.headline)
//                        .foregroundStyle(.black)
//                        .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.05)
//                        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
//                            .foregroundStyle(.blue)
//                            .opacity(0.5))
//                }
//                Button {
//                    if let checkTitle = wishViewModel.wishList.first?.title {
//                        isDuplicated = cartViewModel.checkDuplicate(title: checkTitle)
//                        if isDuplicated == false {
//                            cartViewModel.addCart(model: wishViewModel.wishList.first!)
//                        }
//                    } else {
//                        print("Title does not exist")
//                    }
//                } label: {
//                    Text("Core추가")
//                        .fontWeight(.bold)
//                        .font(.headline)
//                        .foregroundStyle(.black)
//                        .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.05)
//                        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
//                            .foregroundStyle(.green)
//                            .opacity(0.5))
//                }
//                .alert(isPresented: $isDuplicated) {
//                    Alert(title: Text("중복 확인"),
//                          message: Text("이미 장바구니에 있습니다."))
//                }
//                Button {
//                    if let checkTitle = wishViewModel.wishList.first?.title {
//                        isDuplicated = sdCartViewModel.checkDuplicate(title: checkTitle)
//                        if isDuplicated == false {
//                            sdCartViewModel.addCart(model: wishViewModel.wishList.first!)
//                        }
//                    } else {
//                        print("Title does not exist")
//                    }
//                } label: {
//                    Text("SD추가")
//                        .fontWeight(.bold)
//                        .font(.headline)
//                        .foregroundStyle(.black)
//                        .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.05)
//                        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
//                            .foregroundStyle(.red)
//                            .opacity(0.5))
//                }
//                .alert(isPresented: $isDuplicated) {
//                    Alert(title: Text("중복 확인"),
//                          message: Text("이미 장바구니에 있습니다."))
//                }
//            }
//            .padding(.horizontal, 15)
//        }
//        .onAppear {
//            if wishViewModel.wishList.isEmpty {
//                Task {
//                    await wishViewModel.fetchWishList()
//                }
//            }
//        }
//    }
//        
//}

// MARK: - EnvironmentObject 사용

struct ItemView: View {
    
    @EnvironmentObject var wishViewModel: WishViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var sdCartViewModel: SDCartViewModel
    
    @State var isDuplicated = false
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: wishViewModel.wishList.first?.thumbnail ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
            }
            .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.4)
            Text(wishViewModel.wishList.first?.title ?? "")
            Text(wishViewModel.wishList.first?.description ?? "")
                .padding(.horizontal, 20)
            HStack {
                Spacer()
                Text(wishViewModel.wishList.first?.price.dollarAdd() ?? "$")
            }
            .padding(.horizontal, 25)
            HStack {
                Button {
                    Task {
                        await wishViewModel.fetchWishList()
                    }
                } label: {
                    Text("다음")
                        .fontWeight(.bold)
                        .font(.headline)
                        .foregroundStyle(.black)
                        .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.05)
                        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundStyle(.blue)
                            .opacity(0.5))
                }
                Button {
                    if let checkTitle = wishViewModel.wishList.first?.title {
                        isDuplicated = cartViewModel.checkDuplicate(title: checkTitle)
                        if isDuplicated == false {
                            cartViewModel.addCart(model: wishViewModel.wishList.first!)
                        }
                    } else {
                        print("Title does not exist")
                    }
                } label: {
                    Text("Core추가")
                        .fontWeight(.bold)
                        .font(.headline)
                        .foregroundStyle(.black)
                        .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.05)
                        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundStyle(.green)
                            .opacity(0.5))
                }
                .alert(isPresented: $isDuplicated) {
                    Alert(title: Text("중복 확인"),
                          message: Text("이미 장바구니에 있습니다."))
                }
                Button {
                    if let checkTitle = wishViewModel.wishList.first?.title {
                        isDuplicated = sdCartViewModel.checkDuplicate(title: checkTitle)
                        if isDuplicated == false {
                            sdCartViewModel.addCart(model: wishViewModel.wishList.first!)
                        }
                    } else {
                        print("Title does not exist")
                    }
                } label: {
                    Text("SD추가")
                        .fontWeight(.bold)
                        .font(.headline)
                        .foregroundStyle(.black)
                        .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.05)
                        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundStyle(.red)
                            .opacity(0.5))
                }
                .alert(isPresented: $isDuplicated) {
                    Alert(title: Text("중복 확인"),
                          message: Text("이미 장바구니에 있습니다."))
                }
            }
            .padding(.horizontal, 15)
        }
        .onAppear {
            if wishViewModel.wishList.isEmpty {
                Task {
                    await wishViewModel.fetchWishList()
                }
            }
        }
    }
        
}

