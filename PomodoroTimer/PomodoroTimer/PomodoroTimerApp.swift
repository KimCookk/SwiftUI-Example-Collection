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
    
    @Environment(\.scenePhase) var phase
    
    @State var lastActiveTimeStamp: Date = Date()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pomodoroModel)
        }
        .onChange(of: phase) { newValue in
            if pomodoroModel.isStarted {
                if newValue == .background {
                    lastActiveTimeStamp = Date()
                }
                
                if newValue == .active {
                    let currentTimeStampDiff = Date().timeIntervalSince(lastActiveTimeStamp)
                    if pomodoroModel.totalSeconds - Int(currentTimeStampDiff) <= 0 {
                        pomodoroModel.isStarted = false
                        pomodoroModel.totalSeconds = 0
                        pomodoroModel.isFinished = true
                    } else {
                        pomodoroModel.totalSeconds -= Int(currentTimeStampDiff)
                    }
                }
            }
        }
    }
}
