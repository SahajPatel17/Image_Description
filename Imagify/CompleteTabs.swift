//
//  CompleteTabs.swift
//  Imagify
//
//  Created by bca on 10/31/23.
//

import SwiftUI

struct CompleteTabs: View {
    @StateObject var historyContent = History()
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    VStack {
                        Image(systemName: "1.circle")
                        Text("Home")
                    }
                }
            HistoryView()
                .tabItem {
                    VStack {
                        Image(systemName: "2.circle")
                        Text("History")
                    }
                }
        }
        .environmentObject(historyContent)
    }
}

#Preview {
    CompleteTabs()
}
