//
//  ParcelAppCalculatorTutApp.swift
//  ParcelAppCalculatorTut
//
//  Created by Chidubem Obinwanne on 06/02/2026.
//

import SwiftUI
import SwiftData

@main
struct ParcelAppCalculatorTutApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: ParcelDataModel.self)
    }
}
