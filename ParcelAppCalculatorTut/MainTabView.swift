//
//  MainTabView.swift
//  ParcelAppCalculatorTut
//
//  Created by Chidubem Obinwanne on 13/02/2026.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Calculator", systemImage: "function")
                }
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    MainTabView()
}
