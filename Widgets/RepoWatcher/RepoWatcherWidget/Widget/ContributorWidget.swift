//
//  ContributorWidget.swift
//  RepoWatcherWidgetExtension
//
//  Created by Dongik Song on 12/5/24.
//

import WidgetKit
import SwiftUI

struct ContributorProvider: TimelineProvider {
    func placeholder(in context: Context) -> ContributorEntry {
        ContributorEntry(date: .now, repo: MockData.repoOne)
    }
    
    func getSnapshot(in context: Context, completion: @escaping @Sendable (ContributorEntry) -> Void) {
        let entry = ContributorEntry(date: .now, repo: MockData.repoOne)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<ContributorEntry>) -> Void) {
        Task {
            let nextUpdate = Date().addingTimeInterval(43200)
            
            do {
                //Get Repo
                let repoToShow = RepoURL.tpk
                var repo = try await NetworkManager.shared.getRepo(atUrl: repoToShow)
                let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()
                
                //Get Contributors
                let contributors = try await NetworkManager.shared.getContributors(atUrl: repoToShow + "/contributors")
                
                // Filter to jsut the top 4
                var topFour = Array(contributors.prefix(4))
                
                // Download top four avatars
                for i in topFour.indices {
                    let avatarData = await NetworkManager.shared.downloadImageData(from: topFour[i].avatarUrl)
                    topFour[i].avataData = avatarData ?? Data()
                }
                
                repo.contributors = topFour
                
                // Create Entry & Timeline
                let entry = ContributorEntry(date: .now, repo: repo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate)) // update every 12hours
                completion(timeline)
            } catch {
                print("❌ Error - \(error.localizedDescription)")
            }
           
        }
        
    }
    
    typealias Entry = ContributorEntry
    
}

struct ContributorEntry: TimelineEntry {
    var date: Date
    let repo: Repository
}

struct ContributorEntryView : View {
    var entry: ContributorEntry
    
    var body: some View {
        VStack {
            RepoMediumView(repo: entry.repo)
            Spacer().frame(height: 40)
            ContributorMediumView(repo: entry.repo)
        }
        .containerBackground(for: .widget) {}
    }
}

struct ContributorWidget: Widget {
    let kind: String = "ContributorWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ContributorProvider()) { entry in
            ContributorEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Contributors")
        .description("Keep track of a repository's top contributors.")
        .supportedFamilies([.systemLarge])
    }
}

//struct ContributorWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        ContributorEntryView(entry: ContributorEntry(date: Date(), repo: MockData.repoOne))
//            .previewContext(WidgetPreviewContext(family: .systemLarge))
//            .containerBackground(.fill.tertiary, for: .widget)
//    }
//}


#Preview(as: .systemLarge) {
    ContributorWidget()
} timeline: {
    ContributorEntry(date: .now, repo: MockData.repoOne)
}
