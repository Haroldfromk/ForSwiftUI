//
//  ContributorWidget.swift
//  RepoWatcherWidgetExtension
//
//  Created by Dongik Song on 12/5/24.
//

import WidgetKit
import SwiftUI

struct SingleRepoProvider: AppIntentTimelineProvider {
    
    func placeholder(in context: Context) -> SingleRepoEntry {
        SingleRepoEntry(date: .now, repo: MockData.repoOne)
    }
    
    func snapshot(for configuration: SelectSingleRepo, in context: Context) async -> SingleRepoEntry {
        return SingleRepoEntry(date: .now, repo: MockData.repoOne)
    }
    
    func timeline(for configuration: SelectSingleRepo, in context: Context) async -> Timeline<SingleRepoEntry> {
        let nextUpdate = Date().addingTimeInterval(43200)
        
        do {
            //Get Repo
            let repoToShow = RepoURL.prefix + configuration.repo!
            var repo = try await NetworkManager.shared.getRepo(atUrl: repoToShow)
            let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
            repo.avatarData = avatarImageData ?? Data()
            
            if context.family == .systemLarge {
                //Get Contributors
                let contributors = try await NetworkManager.shared.getContributors(atUrl: repoToShow + "/contributors")
                
                // Filter to just the top 4
                var topFour = Array(contributors.prefix(4))
                
                // Download top four avatars
                for i in topFour.indices {
                    let avatarData = await NetworkManager.shared.downloadImageData(from: topFour[i].avatarUrl)
                    topFour[i].avataData = avatarData ?? Data()
                }
                
                repo.contributors = topFour
            }
            
            // Create Entry & Timeline
            let entry = SingleRepoEntry(date: .now, repo: repo)
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        } catch {
            return Timeline(entries: [], policy: .after(nextUpdate))
        }
    }
}


struct SingleRepoEntry: TimelineEntry {
    var date: Date
    let repo: Repository
}

struct SingleRepoEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: SingleRepoEntry
    
    var body: some View {
        switch family {
        case .systemMedium:
            RepoMediumView(repo: entry.repo)
                .containerBackground(for: .widget) {}
        case .systemLarge:
            VStack {
                RepoMediumView(repo: entry.repo)
                Spacer().frame(height: 40)
                ContributorMediumView(repo: entry.repo)
            }
            .containerBackground(for: .widget) {}
        case .systemSmall, .systemExtraLarge, .accessoryCircular, .accessoryRectangular, .accessoryInline:
            EmptyView()
        @unknown default:
            EmptyView()
        }
    }
}

@main
struct SingleRepoWidget: Widget {
    let kind: String = "SingleRepoWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: SelectSingleRepo.self, provider: SingleRepoProvider()) { entry in
            SingleRepoEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Single Repo")
        .description("Track a single Repsitory")
        .supportedFamilies([.systemMedium, .systemLarge])
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
    SingleRepoWidget()
} timeline: {
    SingleRepoEntry(date: .now, repo: MockData.repoOne)
}

