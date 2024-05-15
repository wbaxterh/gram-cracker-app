//
//  ContentView.swift
//  GramCracker
//
//  Created by Wes Huber on 4/28/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var coordinator = NavigationCoordinator()

    var body: some View {
        NavigationView {
            switch coordinator.currentPage {
            case .welcome:
                WelcomeView(coordinator: coordinator)
            case .signIn:
                SignInView(coordinator: coordinator)
            case .register:
                RegisterView(coordinator: coordinator)
            case .homeScreen:
                HomeScreen(coordinator: coordinator)
            case .imageUpload:
                ImageUploadView(coordinator: coordinator)
            case .captionView(let caption):
                CaptionView(caption: caption, coordinator: coordinator)
            }
        }
    }
}

