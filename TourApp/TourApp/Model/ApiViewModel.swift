//
//  ApiViewModel.swift
//  TourApp
//
//  Created by Dongik Song on 11/12/24.
//
import Foundation

@MainActor class ApiViewModel: ObservableObject {
    @Published var apiData = [Tour]()
    
    init() {
        Task {
            await fetchData()
        }
    }
    
    func fetchData() async {
        let url = "https://run.mocky.io/v3/42391865-6e96-4db3-9f68-1e2970796cad"
        guard let downloadedData: [Tour] = await ApiService().downloadData(fromURL: url) else { return }
        apiData = downloadedData
    }
}
