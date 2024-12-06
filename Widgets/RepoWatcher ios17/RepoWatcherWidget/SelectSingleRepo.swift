//
//  SelectSingleRepo.swift
//  RepoWatcher
//
//  Created by Dongik Song on 12/6/24.
//

import Foundation
import AppIntents

@available(iOS 17.0, macOS 14.0, watchOS 10.0, *)
struct SelectSingleRepo: AppIntent, WidgetConfigurationIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "SelectSingleRepoIntent"

    static var title: LocalizedStringResource = "Select Single Repo"
    static var description = IntentDescription("Choose a repository to watch")

    @Parameter(title: "Repo", optionsProvider: RepoOptionsProvider())
    var repo: String?

    struct RepoOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            // TODO: Return possible options here.
            guard let repos = UserDefaults.shared.value(forKey: UserDefaults.repoKey) as? [String] else {
                throw UserDefaultsError.retrieval
            }
            return repos
        }
        
        func defaultResult() async -> String? {
            "sallen0400/swift-news"
        }
    }

//    static var parameterSummary: some ParameterSummary {
//        Summary()
//    }
//
//    func perform() async throws -> some IntentResult {
//        // TODO: Place your refactored intent handler code here.
//        return .result()
//    }
}


