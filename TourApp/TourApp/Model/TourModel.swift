//
//  TourModel.swift
//  TourApp
//
//  Created by Dongik Song on 11/4/24.
//

import Foundation

struct TourModel: Hashable {

    var title: String
    var imageUrl: String
    var description: String
    var address: String
    var latitude: Double
    var longitude: Double
    
    var resList: [restaurantModel]
    
}

struct restaurantModel: Hashable {
    
    var imageUrl: String
    var shopTitle: String
    var shopUrl: String
    
}

// MARK: - Dummy
//private var tours: [TourModel] = [
//    TourModel(title: "해운대",
//              imageUrl: "https://www.visitbusan.net/uploadImgs/files/cntnts/20191229153531987_oen",
//              description: "해운대해수욕장은 대한민국 부산광역시 해운대구 중동과 우동에 걸쳐서 위치한 대한민국 최대규모의 해수욕장이다.\n모래사장의 총면적은 120,000m², 길이는 1.5 km,\n폭은 70m ~ 90m이다",
//              address: "부산광역시 해운대구 해운대해변로 280",
//              latitude: 35.1594965,
//              longitude: 129.162576,
//              resList: [
//        restaurantModel(imageUrl: "https://d12zq4w4guyljn.cloudfront.net/750_750_20241107034546461_photo_be93782c8c6f.jpg",
//                  shopTitle: "해목",
//                  shopUrl: "https://guide.michelin.com/kr/ko/busan-region/busan_1025838/restaurant/haemok"),
//        restaurantModel(imageUrl: "https://d12zq4w4guyljn.cloudfront.net/750_750_20240911102116_photo1_88fad60e925b.jpg",
//                  shopTitle: "해운대 암소갈비집",
//                  shopUrl: "https://www.xn--w39a45ki5j7idj7fkmcgy7b.com/"),
//        restaurantModel(imageUrl: "https://d12zq4w4guyljn.cloudfront.net/750_750_20240901075713544_photo_H0XuaBJruCxr.jpg",
//                  shopTitle: "해운대기와집 대구탕",
//                  shopUrl: "https://m.blog.naver.com/kizaki56/222438137548"),
//        restaurantModel(imageUrl: "https://d12zq4w4guyljn.cloudfront.net/750_750_20241024125705_photo1_12cc712c920a.jpg",
//                  shopTitle: "나가하마만게츠",
//                  shopUrl: "https://guide.michelin.com/kr/ko/busan-region/busan_1025838/restaurant/nagahama-mangetsu"),
//        restaurantModel(imageUrl: "https://d12zq4w4guyljn.cloudfront.net/750_750_20241002045500_photo1_62b739e90db1.jpg",
//                  shopTitle: "바다마루전복죽",
//                  shopUrl: "https://m.blog.naver.com/suuujan_/222316689401")
//    ])
//]
