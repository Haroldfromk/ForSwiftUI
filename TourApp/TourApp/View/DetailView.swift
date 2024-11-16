//
//  DetailView.swift
//  TourApp
//
//  Created by Dongik Song on 11/4/24.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    var title: String
    var imageUrl: String
    var description: String
    var address: String
    var coordinate: CLLocationCoordinate2D
    
    var shopList = [ResList]()
    
    @State var cameraPosition: MapCameraPosition
    
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 350)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.brown)
                    .frame(maxWidth: 100)
            }
            Text(description)
                .padding(.all)
                .frame(height: 200)
            Text(address)
                .padding(.horizontal)
            Map(position: $cameraPosition) {
                Annotation(title, coordinate: coordinate) {
                    ZStack {
                        Image(systemName: "flag.checkered")
                    }
                }
                
            }
            .frame(maxWidth: 350)
            .frame(height: 150)
            Text("\(title) 근처 맛집")
            Spacer()
            PageView(lists: shopList)
                .frame(width: 200, height: 200)
        }
    }
}

#Preview {
    DetailView(title: "해운대",
               imageUrl: "https://www.visitbusan.net/uploadImgs/files/cntnts/20191229153531987_oen",
               description: "해운대해수욕장은 대한민국 부산광역시 해운대구 중동과 우동에 걸쳐서 위치한 대한민국 최대규모의 해수욕장이다.\n모래사장의 총면적은 120,000m², 길이는 1.5 km,\n폭은 70m ~ 90m이다",
               address: "부산광역시 해운대구 해운대해변로 280",
               coordinate: CLLocationCoordinate2D(
                latitude: 35.1594965,
                longitude: 129.162576),
               cameraPosition: .camera(MapCamera(
                centerCoordinate: CLLocationCoordinate2D(
                    latitude: 35.1594965,
                    longitude: 129.162576),
                distance: 1000,
                heading: 90,
                pitch: 80
               )))
}
