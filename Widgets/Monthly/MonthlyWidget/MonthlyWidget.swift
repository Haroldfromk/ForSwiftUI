//
//  MonthlyWidget.swift
//  MonthlyWidget
//
//  Created by Dongik Song on 12/3/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), configuration: ConfigurationAppIntent())
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> DayEntry {
        DayEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<DayEntry> {
        var entries: [DayEntry] = []
        
        // Generate a timeline consisting of seven entries an hour apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDate = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startOfDate, configuration: configuration)
            entries.append(entry)
        }
        
        return Timeline(entries: entries, policy: .atEnd)
    }
    
    //    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
    //        // Generate a list containing the contexts this widget is relevant in.
    //    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct MonthlyWidgetEntryView : View {
    @Environment(\.showsWidgetContainerBackground) var showsBackground
    @Environment(\.widgetRenderingMode) var renderingMode
    
    var entry: DayEntry
    var config: MonthConfig
    
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
                        .font(.title3)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.6)
                        .foregroundStyle(showsBackground ? config.weekdayTextColor : .white)
                    Spacer()
                }
                .id(entry.date)
                .transition(.push(from: .trailing))
                .animation(.bouncy, value: entry.date)
                
                Text(entry.date.dayDisplayFormat)
                    .font(.system(size: 80, weight: .heavy))
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
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            MonthlyWidgetEntryView(entry: entry)
            //.containerBackground(.gray.gradient, for: .widget)
        }
        .configurationDisplayName("Monthly Style Widget")
        .description("The theme of the widget changes based on month.")
        .supportedFamilies([.systemSmall])
        .disfavoredLocations([.homeScreen], for: [.systemSmall])
    }
}

//struct MonthlyWidgetEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MonthlyWidgetEntryView(entry: DayEntry(date: dateToDisplay(month: 11, day: 22), configuration: .smiley))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//
//    static func dateToDisplay(month: Int, day: Int) -> Date {
//        let components = DateComponents(calendar: Calendar.current,
//                                        year: 2024,
//                                        month: month,
//                                        day: day)
//        return Calendar.current.date(from: components)!
//    }
//}

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

struct MockData {
    static let dayOne = DayEntry(date: dateToDisplay(month: 9, day: 4), configuration: ConfigurationAppIntent())
    static let dayTwo = DayEntry(date: dateToDisplay(month: 10, day: 5), configuration: ConfigurationAppIntent())
    static let dayThree = DayEntry(date: dateToDisplay(month: 11, day: 6), configuration: ConfigurationAppIntent())
    static let dayFour = DayEntry(date: dateToDisplay(month: 12, day: 7), configuration: ConfigurationAppIntent())
    
    
    static func dateToDisplay(month: Int, day: Int) -> Date {
        let components = DateComponents(calendar: Calendar.current,
                                        year: 2022,
                                        month: month,
                                        day: day)
        
        return Calendar.current.date(from: components)!
    }
}
