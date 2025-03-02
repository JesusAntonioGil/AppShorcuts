//
//  AppShorcutsApp.swift
//  AppShorcuts
//
//  Created by Jesus Antonio Gil on 2/3/25.
//

import SwiftUI


@main
struct AppShorcutsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Memory.self)
        }
    }
}
