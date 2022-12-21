//
//  ContentView.swift
//  WidgetExercise
//
//  Created by Lexline Johnson on 20/12/2022.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @State private var widgetText: String = ""
    var sharedDefaults = UserDefaults(suiteName: "group.com.Lexline.sharedDefaults")
    
    var body: some View {
        VStack {
            TextField("Enter widget text here", text: $widgetText)
                .multilineTextAlignment(.center)
                .frame(maxWidth: UIScreen.main.bounds.width - 200)
                .fixedSize()
            Button("Update Widget") {
                sharedDefaults?.set(widgetText, forKey: "widgetText")
                WidgetCenter.shared.reloadAllTimelines()    // refresh widget
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
