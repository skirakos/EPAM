//
//  GeoDBExplorerApp.swift
//  GeoDBExplorer
//
//  Created by Seda Kirakosyan on 03.09.25.
//

import SwiftUI

@main
struct GeoDBExplorerApp: App {
    @AppStorage("app.language") private var lang: String = "en"
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                    .environment(\.locale, Locale(identifier: lang))
                    .id(lang)
        }
    }
}
