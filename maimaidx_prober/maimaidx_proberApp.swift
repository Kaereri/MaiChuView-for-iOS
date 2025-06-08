//
//  maimaidx_proberApp.swift
//  maimaidx_prober
//
//  Created by 枫羽云玲 on 2025/6/2.
//

import SwiftUI
import SwiftData

@main
struct maimaidx_proberApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:User.self)
    }
}
