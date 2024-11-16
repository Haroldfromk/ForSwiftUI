//
//  JsonModel.swift
//  TourApp
//
//  Created by Dongik Song on 11/8/24.
//

import Foundation

struct JsonModel: Codable {
    let tours: [Tour]
}

// MARK: - Tour
struct Tour: Codable, Hashable {

    let id = UUID()
    let title: String
    let imageURL: String
    let description, address: String
    let latitude, longitude: Double
    let resList: [ResList]
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "imageUrl"
        case description, address, latitude, longitude, resList
    }
}

// MARK: - ResList
struct ResList: Codable, Hashable {
    
    var imageURL: String
    var shopTitle: String
    var shopURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case shopTitle
        case shopURL = "shopUrl"
    }
}


class loadJsonModel: ObservableObject {
    @Published var tours = [Tour]()
    
    init() {
        load()
    }
    
    func load() {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json")
        else {
            print("Json file not found")
            return
        }
      
        let data = (try? Data(contentsOf: url))!
        let decodedData = try? JSONDecoder().decode(JsonModel.self, from: data)
        
        self.tours = decodedData!.tours
    }
}
