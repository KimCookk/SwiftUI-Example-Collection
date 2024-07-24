//
//  CustomNavBarContainerView.swift
//  CustomNavigationView
//
//  Created by 김태성 on 7/24/24.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var subtitle: String? = nil
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
            VStack(spacing: 0) {
                CustomNavBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)
                content
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
            }
            .onPreferenceChange(CustomNavBarTitlePreferenceKeys.self, perform: { value in
                self.title = value
            })
            .onPreferenceChange(CustomNavBarSubTitlePreferenceKeys.self, perform: { value in
                self.subtitle = value
            })
            .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKeys.self, perform: { value in
                self.showBackButton = !value
            })
    }
}

#Preview {
    CustomNavBarContainerView {
        ZStack {
            Color.green.ignoresSafeArea()
            
            Text("Hello, world!")
                .foregroundStyle(.white)
                .customNavigationTitle("New Title")
                .customNavigationSubTitle("subtitle")
                .customNavigationBarBackButtonHidden(true)
        }
    }
}
