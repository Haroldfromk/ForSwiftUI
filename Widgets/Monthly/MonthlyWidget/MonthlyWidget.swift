//
//  MonthlyWidget.swift
//  MonthlyWidget
//
//  Created by Dongik Song on 12/3/24.
//

import WidgetKit
import SwiftUI
import AppIntents

struct Provider: AppIntentTimelineProvider {
    
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), showFunFont: false)
    }
    
    func snapshot(for configuration: ChangeFontIntent, in context: Context) async -> DayEntry {
        return DayEntry(date: Date(), showFunFont: false)
    }
    
    func timeline(for configuration: ChangeFontIntent, in context: Context) async -> Timeline<DayEntry> {
        var entries: [DayEntry] = []
        let showFunFont = configuration.funFont ?? false
        
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDate = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startOfDate, showFunFont: showFunFont)
            entries.append(entry)
        }
        return Timeline(entries: entries, policy: .atEnd)
    }
    
}

struct DayEntry: TimelineEntry {
    let date: Date
    let showFunFont: Bool
}

struct MonthlyWidgetEntryView : View {
    @Environment(\.showsWidgetContainerBackground) var showsBackground
    @Environment(\.widgetRenderingMode) var renderingMode
    
    var entry: DayEntry
    var config: MonthConfig
    let funFontName = "Chalkduster"
    
    init(entry: DayEntry) {
        self.entry = entry
        self.config = MonthConfig.determineConfig(from: entry.date)
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(config.emojiText)
                        .font(.title)
                        .background(Color.black)
                        .compositingGroup()
                        .luminanceToAlpha()
                    Text(entry.date.weekDayDisplayFormat)
                        .font(entry.showFunFont ? .custom(funFontName, size: 24) : .title3)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.6)
                        .foregroundStyle(showsBackground ? config.weekdayTextColor : .white)
                        .widgetAccentable()
                    Spacer()
                }
                .id(entry.date)
                .transition(.push(from: .trailing))
                .animation(.bouncy, value: entry.date)
                
                Text(entry.date.dayDisplayFormat)
                    .font(entry.showFunFont ? .custom(funFontName, size: 80) : .system(size: 80, weight: .heavy))
                    .foregroundStyle(showsBackground ? config.dayTextColor : .white)
                    .contentTransition(.numericText())
                    .widgetAccentable()
            }
            .padding(2)
        }
        .containerBackground(for: .widget){
            ContainerRelativeShape()
                .fill(config.backgroundColor.gradient)
        }
    }
}

struct MonthlyWidget: Widget {
    let kind: String = "MonthlyWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ChangeFontIntent.self, provider: Provider()) { entry in
            MonthlyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Monthly Style Widget")
        .description("The theme of the widget changes based on month.")
        .supportedFamilies([.systemSmall])
        //.disfavoredLocations([.homeScreen], for: [.systemSmall])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

extension Date {
    var weekDayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day())
    }
}

#Preview(as: .systemSmall) {
    MonthlyWidget()
} timeline: {
    MockData.dayOne
    MockData.dayTwo
    MockData.dayThree
    MockData.dayFour
}

struct ChangeFontIntent: AppIntent, WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Fun Font"
    static var description: IntentDescription = .init(stringLiteral: "Switch to a fun font")
    
    @Parameter(title: "Fun Font", default: false)
    var funFont: Bool?
}

struct MockData {
    static let dayOne = DayEntry(date: dateToDisplay(month: 9, day: 4), showFunFont: true)
    static let dayTwo = DayEntry(date: dateToDisplay(month: 10, day: 5), showFunFont: false)
    static let dayThree = DayEntry(date: dateToDisplay(month: 11, day: 6), showFunFont: true)
    static let dayFour = DayEntry(date: dateToDisplay(month: 12, day: 7), showFunFont: false)
    
    
    static func dateToDisplay(month: Int, day: Int) -> Date {
        let components = DateComponents(calendar: Calendar.current,
                                        year: 2022,
                                        month: month,
                                        day: day)
        
        return Calendar.current.date(from: components)!
    }
}
