//
//  TaskManagerWidget.swift
//  TaskManagerWidget
//
//  Created by Can Kanbur on 1.06.2023.
//

import Intents
import SwiftUI
import WidgetKit

struct Provider: IntentTimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct TaskManagerWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(colors: [Color.pink, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                Image("rocket-small")
                    .resizable()
                    .scaledToFit()
                Image("logo")
                    .resizable()
                    .frame(width: 36, height: 36, alignment: .center)
                    .offset(
                        x: (geo.size.width / 2) - 20,
                        y: (geo.size.height / -2) + 20)
                    .padding(.top,12)
                    .padding(.trailing,10)
                HStack{
                    Text("Just Do It")
                        .foregroundColor(.white)
                        .font(.system(size:12, weight: .bold, design: .rounded))
                        .padding(.horizontal,12)
                        .padding(.vertical,2)
                        .background(.black.opacity(0.2))
                        .clipShape(Capsule())
                    if widgetFamily != .systemSmall {
                        Spacer()
                    }
                }
                .padding()
                .offset(y:(geo.size.height / 2 ) - 24)
            }
        }
    }
}

struct TaskManagerWidget: Widget {
    let kind: String = "TaskManagerWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            TaskManagerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct TaskManagerWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskManagerWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            TaskManagerWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            TaskManagerWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
