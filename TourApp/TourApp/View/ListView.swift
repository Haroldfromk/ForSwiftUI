//
//  ListView.swift
//  TourApp
//
//  Created by Dongik Song on 10/31/24.
//

import SwiftUI
import MapKit

struct ListView: View {
    
    @ObservedObject var json = loadJsonModel()
    @StateObject var vm = ApiViewModel()
    
    var body: some View {
        NavigationStack {
            Text("관광 고고")
                List {
                    ForEach(vm.apiData, id: \.self) { tour in
                        NavigationLink(value: tour) {
                            CellView(title: tour.title, imageUrl: tour.imageURL)
                        }
                    }
                }
            .navigationDestination(for: Tour.self) { model in
                DetailView(title: model.title, imageUrl: model.imageURL, description: model.description, address: model.address, coordinate: CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude), shopList: model.resList, cameraPosition: .camera(MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude), distance: 500, heading: 90, pitch: 80)))
            }
        }
//        .onAppear {
//            if vm.apiData.isEmpty {
//                Task {
//                    await vm.fetchData()
//                }
//            }
//        }
        
    }
}

#Preview {
    ListView()
}
