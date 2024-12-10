//
//  UserDefaults+Extension.swift
//  RepoWatcher
//
//  Created by Dongik Song on 12/6/24.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        UserDefaults(suiteName: "group.co.harold.RepoWatcher")!
    }
    
    static let repoKey = "repos"
}

enum UserDefaultsError: Error {
    case retrieval
}
