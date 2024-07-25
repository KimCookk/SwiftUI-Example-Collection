//
//  CustomTabBarContainerView.swift
//  CustomTabBar
//
//  Created by 김태성 on 7/25/24.
//

import SwiftUI

//struct TabView2<SelectionValue, Content> : View where SelectionValue : Hashable, Content : View {
//    
//}
//
//struct TabView3<SelectionValue: Hashable, Content: View>: View {
//    var body: some View {
//        
//    }
//}

struct CustomTabBarContainerView<Content: View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
            
            CustomTabBarView(tabs: tabs, 
                             selection: $selection,
                             localSelection: selection)

        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

//let testTabs: [TabBarItem] = [
//    TabBarItem(iconName: "house", title: "Home", color: Color.red),
//    TabBarItem(iconName: "heart", title: "Favorite", color: Color.blue),
//    TabBarItem(iconName: "person", title: "Profile", color: Color.green)
//]

#Preview {
    CustomTabBarContainerView(selection: .constant(testTabs.first!)) {
        Color.red
    }
}
