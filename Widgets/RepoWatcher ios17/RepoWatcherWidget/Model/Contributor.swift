//
//  Contributor.swift
//  RepoWatcher
//
//  Created by Dongik Song on 12/5/24.
//

import Foundation

struct Contributor: Identifiable {
    let id = UUID()
    let login: String
    let avatarUrl: String
    let contributions: Int
    var avataData: Data
}

extension Contributor {
    struct CodingData: Decodable {
        let login: String
        let avatarUrl: String
        let contributions: Int
        
        var contributor: Contributor {
            Contributor(login: login,
                        avatarUrl: avatarUrl,
                        contributions: contributions,
                        avataData: Data())
        }
    }
}
