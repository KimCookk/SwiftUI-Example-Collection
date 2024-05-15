//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by 김태성 on 5/15/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pomodoroModel: PomodorModel
    
    var body: some View {
        HomeView()
            .environmentObject(pomodoroModel)
    }
}

#Preview {
    ContentView()
}
