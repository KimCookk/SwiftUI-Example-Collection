//
//  MyToDosApp.swift
//  MyToDos
//
//  Created by 김태성 on 7/9/24.
//

import SwiftUI

@main
struct MyToDosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataStore())
        }
    }
}
