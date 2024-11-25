//
//  MainView.swift
//  ApiCart
//
//  Created by Dongik Song on 11/14/24.
//

import SwiftUI

// MARK: - State,ObservedObject 사용
//struct MainView: View {
//    @StateObject var wishViewModel = WishViewModel()
//    @StateObject var cartViewModel = CartViewModel()
//    @StateObject var sdCartViewModel = SDCartViewModel()
//
//    var body: some View {
//        NavigationStack {
//            TabView {
//                Tab("Display", systemImage: "eye") {
//                    ItemView(wishViewModel: wishViewModel,
//                             cartViewModel: cartViewModel,
//                             sdCartViewModel: sdCartViewModel)
//                }
//                Tab("CoreCart", systemImage: "cart") {
//                    CoreCartView(cartViewModel: cartViewModel)
//                }
//                Tab("SDCart", systemImage: "cart.circle") {
//                    SDCartView(sdCartViewModel: sdCartViewModel)
//                }
//                Tab("Test", systemImage: "star") {
//                    TestView()
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Menu {
//                        Button {
//                            cartViewModel.deleteAllData()
//                        } label: {
//                            Text("Core 장바구니 비우기")
//                            Image(systemName: "cart.badge.minus")
//                        }
//                        Button {
//                            sdCartViewModel.deleteAllCart()
//                        } label: {
//                            Text("SD 장바구니 비우기")
//                            Image(systemName: "cart.badge.minus")
//                        }
//                    } label: {
//                        Image(systemName: "cart")
//                    }
//                }
//            }
//        }
//    }
//}

// MARK: - EnvironmentObject 사용
struct MainView: View {
    @StateObject var wishViewModel = WishViewModel()
    @StateObject var cartViewModel = CartViewModel()
    @StateObject var sdCartViewModel = SDCartViewModel()

    var body: some View {
        NavigationStack {
            TabView {
                Tab("Display", systemImage: "eye") {
                    ItemView()
                }
                Tab("CoreCart", systemImage: "cart") {
                    CoreCartView(cartViewModel: cartViewModel)
                }
                Tab("SDCart", systemImage: "cart.circle") {
                    SDCartView(sdCartViewModel: sdCartViewModel)
                }
                Tab("Test", systemImage: "star") {
                    TestView()
                }
            }
            .environmentObject(wishViewModel)
            .environmentObject(cartViewModel)
            .environmentObject(sdCartViewModel)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            cartViewModel.deleteAllData()
                        } label: {
                            Text("Core 장바구니 비우기")
                            Image(systemName: "cart.badge.minus")
                        }
                        Button {
                            sdCartViewModel.deleteAllCart()
                        } label: {
                            Text("SD 장바구니 비우기")
                            Image(systemName: "cart.badge.minus")
                        }
                    } label: {
                        Image(systemName: "cart")
                    }
                }
            }
        }
    }
}
