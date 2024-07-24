//
//  AppNavBarView.swift
//  CustomNavigationView
//
//  Created by 김태성 on 7/24/24.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                CustomNavLink(destination: Text("Destination")
                                            .customNavigationTitle("Seconds Screen")
                                            .customNavigationSubTitle("Subtitle should be showing!!!"),
                              label: {
                    Text("Navigate")
                })
            }
            .custonNavBarItems(title: "New Title!",
                               subTitle: "Subtitle",
                               backButtonHideen: true)
        }
    }
}

#Preview {
    AppNavBarView()
}

extension AppNavBarView {
    private var defaultNavView: some View {
        NavigationView {
            ZStack {
                Color.red.ignoresSafeArea()
                
                NavigationLink {
                    Text("Destination")
                        .navigationTitle("Title 2")
                        .navigationBarBackButtonHidden(false)
                } label: {
                    Text("Navigate")
                }

            }
            .navigationTitle("Nav title here")
        }
    }
}
