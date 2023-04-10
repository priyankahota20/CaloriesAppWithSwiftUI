//
//  CaloriesAppApp.swift
//  CaloriesApp
//
//  Created by Capgemini-DA161 on 4/6/23.
//

import SwiftUI

@main
struct CaloriesAppApp: App {
    @StateObject var vm: CaloriesDataModel = CaloriesDataModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CaloriesDataModel())
        }
    }
}
