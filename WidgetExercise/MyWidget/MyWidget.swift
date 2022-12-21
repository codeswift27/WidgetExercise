//
//  MyWidget.swift
//  MyWidget
//
//  Created by Lexline Johnson on 21/12/2022.
//

import WidgetKit
import SwiftUI

struct TextProvider: TimelineProvider {
    func placeholder(in context: Context) -> TextEntry {
        TextEntry(date: Date(), text: UserDefaults(suiteName: "group.com.Lexline.sharedDefaults")?.string(forKey: "widgetText") ?? "Tap to set up text")
    }

    func getSnapshot(in context: Context, completion: @escaping (TextEntry) -> ()) {
        let entry = TextEntry(date: Date(), text: UserDefaults(suiteName: "group.com.Lexline.sharedDefaults")?.string(forKey: "widgetText") ?? "Tap to set up text")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [TextEntry] = [TextEntry(date: Date(), text: UserDefaults(suiteName: "group.com.Lexline.sharedDefaults")?.string(forKey: "widgetText") ?? "Tap to set up text")]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct TextEntry: TimelineEntry {
    let date: Date
    let text: String
}

struct MyWidgetEntryView : View {
    var entry: TextProvider.Entry

    var body: some View {
        Text(entry.text)
            .foregroundColor(Color(UIColor.lightText))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [.orange, Color(red: 235 / 255, green: 100 / 255, blue: 52 / 255)]), startPoint: .top, endPoint: .bottom)
            )
    }
}

struct MyWidget: Widget {
    let kind: String = "MyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TextProvider()) { entry in
            MyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Text Widget")
        .description("A widget that displays text.")
    }
}

struct MyWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyWidgetEntryView(entry: TextEntry(date: Date(), text: "placeholder"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
