//
//  EffectiveMobileTestApp.swift
//  EffectiveMobileTest
//
//  Created by Руслан Трищенков on 08.12.2022.
//

import SwiftUI

@main
struct EffectiveMobileTestApp: App {
    @StateObject var networkManager = NetworkServiceManager()
    @StateObject var cartManager = CartManager()
    var body: some Scene {
        WindowGroup {
            LoadingPage()
                .environmentObject(networkManager)
                .environmentObject(cartManager)
        }
    }
}
