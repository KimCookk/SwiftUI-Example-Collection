//
//  PomodoroTimerApp.swift
//  PomodoroTimer
//
//  Created by 김태성 on 5/15/24.
//

import SwiftUI

@main
struct PomodoroTimerApp: App {
    // MARK: Since We're doing Background fetching Intializing Here
    @StateObject var pomodoroModel: PomodorModel = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pomodoroModel)
        }
    }
}
