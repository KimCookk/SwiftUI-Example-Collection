//
//  CustomNavLink.swift
//  CustomNavigationView
//
//  Created by 김태성 on 7/24/24.
//

import SwiftUI

struct CustomNavLink<Label: View, Destination: View>: View {
    
    let destination: Destination
    let label: Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink(
            destination: CustomNavBarContainerView(content: {
                destination
                })
                .navigationBarHidden(true)
            ,
            label: {
                label
        })
    }
}

#Preview {
    CustomNavView {
        CustomNavLink(
            destination: Text("Destination"),
            label: {
            Text("Click Me")
        })
    }
}
