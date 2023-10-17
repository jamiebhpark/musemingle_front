//
//  musemingleApp.swift
//  musemingle
//
//  Created by JONGHUN PARK on 2023/08/17.
//
import SwiftUI

@main
struct musemingleApp: App {
    @StateObject private var appViewModel = AppViewModel()
    @StateObject private var loginStatusViewModel = LoginStatusViewModel()

    init() {
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
    }
    var body: some Scene {
        WindowGroup {
            if loginStatusViewModel.isLoggedIn {
                MainView().environmentObject(appViewModel)
            } else {
                WelcomeView(viewModel: appViewModel, loginStatus: loginStatusViewModel)
            }
        }
    }
}
