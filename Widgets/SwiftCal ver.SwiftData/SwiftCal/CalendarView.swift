//
//  ContentView.swift
//  SwiftCal
//
//  Created by Dongik Song on 12/6/24.
//

import SwiftUI
import SwiftData
import WidgetKit

struct CalendarView: View {
    @Environment(\.modelContext) private var context
    @Query(filter: #Predicate<Day> { $0.date >= startDate && $0.date <= endDate }, sort: \Day.date)
    var days: [Day]
    
    static var startDate: Date { .now.startOfCalendarWithPrefixDays }
    static var endDate: Date { .now.endOfMonth }
    
    var body: some View {
        NavigationView {
            VStack {
                CalendarHeaderView()
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                    ForEach(days) { day in
                        if day.date.monthInt != Date().monthInt {
                            Text(" ")
                        } else {
                            Text(day.date.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(day.didStudy ? .orange : .secondary)
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background {
                                    Circle()
                                        .foregroundStyle(.orange.opacity(day.didStudy ? 0.3 : 0.0))
                                }
                                .onTapGesture {
                                    if day.date.dayInt <= Date().dayInt {
                                        day.didStudy.toggle()
                                        try? context.save()
                                        WidgetCenter.shared.reloadTimelines(ofKind: "SwiftCalWidget")
                                        ControlCenter.shared.reloadControls(ofKind: "SwiftCalControl")
                                    } else {
                                        print("Can't study in the future!")
                                    }
                                }
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle(Date().formatted(.dateTime.month(.wide)))
            .padding()
            .onAppear {
                if days.isEmpty {
                    createMonthDays(for: .now.startOfPreviousMonth)
                    createMonthDays(for: .now)
                    
                } else if days.count < 10 {
                    // Is this Only the prefix days
                    createMonthDays(for: .now)
                }
            }
        }
    }
    
    func createMonthDays(for date: Date) {
        for dayOffset in 0..<date.numberOfDaysInMonth {
            let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: date.startOfMonth)!
            let newDay = Day(date: date, didStudy: false)
            context.insert(newDay)
        }
    }
 
}


//#Preview {
//    CalendarView()
//}
