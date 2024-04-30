//
//  RootView.swift
//  CustomTabBar-Chris
//
//  Created by 김태성 on 4/30/24.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tabs = .contacts
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .font(.headline)
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    RootView()
}
