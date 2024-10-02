//
//  swiftUIPropertyChangeApp.swift
//  swiftUIPropertyChange
//
//  Created by 김태성 on 10/2/24.
//

import SwiftUI

@main
struct swiftUIPropertyChangeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
