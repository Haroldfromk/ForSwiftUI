//
//  SwiftCalWidget.swift
//  SwiftCalWidget
//
//  Created by Dongik Song on 12/9/24.
//

import WidgetKit
import SwiftUI
import SwiftData
import AppIntents

struct Provider: TimelineProvider {
    
    
    func placeholder(in context: Context) -> CalendarEntry {
        CalendarEntry(date: Date(), days: [])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (CalendarEntry) -> ()) {
        let entry = CalendarEntry(date: Date(), days: fetchDays())
        print("Snapshot entry: \(entry)")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = CalendarEntry(date: Date(), days: fetchDays())
        let timeline = Timeline(entries: [entry], policy: .after(.now.endOfDay))
        completion(timeline)
    }
    
    func fetchDays() -> [Day] {
        let startDate = Date().startOfCalendarWithPrefixDays
        let endDate = Date().endOfMonth
        
        let predicate = #Predicate<Day> {$0.date >= startDate && $0.date <= endDate }
        let descriptor = FetchDescriptor(predicate: predicate, sortBy: [.init(\.date)])
        
        let context = ModelContext(Persistence.container)
        
        return try! context.fetch(descriptor)
    }
    
//    @MainActor func fetchDays() -> [Day] {
//        var sharedStoreURL: URL {
//            let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.HaroldSong.SwiftCal")!
//            return (container.appendingPathComponent("SwiftCal.sqlite"))
//        }
//        
//        let container: ModelContainer = {
//            let config = ModelConfiguration(url: sharedStoreURL)
//            return try! ModelContainer(for: Day.self, configurations: config)
//        }()
//        
//        var startDate: Date { .now.startOfCalendarWithPrefixDays }
//        var endDate: Date { .now.endOfMonth }
//        
//        let predicate = #Predicate<Day> {$0.date > startDate && $0.date < endDate }
//        let descriptor = FetchDescriptor(predicate: predicate, sortBy: [.init(\.date)])
//        
//        return try! container.mainContext.fetch(descriptor)
//    }
}

struct CalendarEntry: TimelineEntry {
    let date: Date
    let days: [Day]
}

struct SwiftCalWidgetEntryView : View {
    var entry: CalendarEntry
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var today: Day {
        entry.days.filter { Calendar.current.isDate($0.date, inSameDayAs: .now)}.first ?? .init(date: .distantPast, didStudy: false)
    }
    
    var body: some View {
        HStack {
            VStack {
                Link(destination: URL(string: "streak")!) {
                    VStack {
                        Text("\(calculateStreakValue())")
                            .font(.system(size: 70, design: .rounded))
                            .bold()
                            .foregroundStyle(.orange)
                            .widgetAccentable()
                            .contentTransition(.numericText())
                        
                        Text("day streak")
                            .font(.caption)
                            .foregroundStyle(.orange)
                    }
                }
                Button(today.didStudy ? "Studied" : "Study",
                       systemImage: today.didStudy ? "checkmark.circle" : "book",
                       intent: ToggleStudyIntent(date: today.date))
                    .font(.caption2)
                    .tint(today.didStudy ? .mint : .orange)
                    .controlSize(.small)
                    .widgetAccentable()
            }
            .frame(width: 90)
            
            Link(destination: URL(string: "calendar")!) {
                VStack {
                    CalendarHeaderView(font: .caption)
                    LazyVGrid(columns: columns, spacing: 7) {
                        ForEach(entry.days) { day in
                            if day.date.monthInt != Date().monthInt {
                                Text(" ")
                            } else {
                                Text(day.date.formatted(.dateTime.day()))
                                    .font(.caption2)
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(.secondary)
                                    .background {
                                        Circle()
                                            .foregroundStyle(.orange.opacity(day.didStudy ? 0.3 : 0.0))
                                            .scaleEffect(1.5)
                                    }
                                    .didStudyAccentable(day.didStudy)
                            }
                        }
                    }
                }
            }
            .padding(.leading, 6)
        }
        .containerBackground(for: .widget) {
        }
    }
    
    func calculateStreakValue() -> Int {
        guard !entry.days.isEmpty else { return 0 }
        
        let nonfutureDays = entry.days.filter { $0.date.dayInt <= Date().dayInt }
        
        var streakCount = 0
        
        for day in nonfutureDays.reversed() {
            if day.didStudy {
                streakCount += 1
            } else {
                if day.date.dayInt != Date().dayInt {
                    break
                }
            }
        }
        
        return streakCount
    }
    
}

struct SwiftCalWidget: Widget {
    let kind: String = "SwiftCalWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
                SwiftCalWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Swift Study Calendar")
        .description("Track days you study Swift with streaks.")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    SwiftCalWidget()
} timeline: {
    CalendarEntry(date: Date(), days: [])
    CalendarEntry(date: .now, days: [])
}
