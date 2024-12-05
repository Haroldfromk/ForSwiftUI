//
//  MockData.swift
//  RepoWatcherWidgetExtension
//
//  Created by Dongik Song on 12/4/24.
//

import Foundation

struct MockData {
    static let repoOne = Repository(name: "Repository 1",
                                    owner: Owner(avatarUrl: ""),
                                    hasIssues: true,
                                    forks: 65,
                                    watchers: 123,
                                    openIssues: 55,
                                    pushedAt: "2024-11-04T05:22:15Z",
                                    avatarData: Data(),
                                    contributors: [Contributor(login: "Sean Allen", avatarUrl: "", contributions: 42, avataData: Data()),
                                                   Contributor(login: "Michael Jordan", avatarUrl: "", contributions: 25, avataData: Data()),
                                                   Contributor(login: "Steph Curry", avatarUrl: "", contributions: 30, avataData: Data()),
                                                   Contributor(login: "Lebron James", avatarUrl: "", contributions: 12, avataData: Data())])
    
    static let repoTwo = Repository(name: "Repository 2",
                                    owner: Owner(avatarUrl: ""),
                                    hasIssues: true,
                                    forks: 135,
                                    watchers: 253,
                                    openIssues: 245,
                                    pushedAt: "2024-01-04T05:22:15Z",
                                    avatarData: Data())
}
