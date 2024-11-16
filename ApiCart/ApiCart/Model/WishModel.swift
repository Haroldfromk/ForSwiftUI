//
//  WishModel.swift
//  ApiCart
//
//  Created by Dongik Song on 11/14/24.
//

import Foundation

struct WishModel: Codable {
    let id: Int
    let title, description: String
    let price: Double
    let thumbnail: String
}

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

class WishService {
    func downLoadData<T: Codable>(url: String) async -> T? {
        do {
            guard let url = URL(string: url) else { throw NetworkError.badUrl }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }

            return decodedData
            
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }
        
        return nil
    }
}
