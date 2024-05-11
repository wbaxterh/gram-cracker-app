//
//  GramCrackerApp.swift
//  GramCracker
//
//  Created by Wes Huber on 4/28/24.
//

import SwiftUI

@main
struct GramCrackerApp: App {
    @StateObject private var viewModel = AppViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(Color.green)  // Set your desired color
                .edgesIgnoringSafeArea(.all)  // Extend the background to all edges

        }
    }
}
