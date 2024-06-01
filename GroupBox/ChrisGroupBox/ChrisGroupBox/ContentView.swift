//
//  ContentView.swift
//  ChrisGroupBox
//
//  Created by 김태성 on 6/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        GroupBox(label: Label("Settings", systemImage: "gear")) {
            Toggle("Notification Enabled", isOn: .constant(true))
            Toggle("Private account", isOn: .constant(true))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
