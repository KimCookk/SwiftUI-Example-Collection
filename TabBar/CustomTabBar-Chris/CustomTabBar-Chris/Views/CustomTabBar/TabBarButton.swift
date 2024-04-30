//
//  TabBarButton.swift
//  CustomTabBar-Chris
//
//  Created by 김태성 on 4/30/24.
//

import SwiftUI

struct TabBarButton: View {
    
    var buttonText: String
    var imageName: String
    var isActive: Bool
    var buttonAction: () -> ()
    
    var body: some View {
        Button(action: {
            buttonAction()
        }) {
            GeometryReader { geo in
                
                if(isActive) {
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: geo.size.width/2, height: 4)
                        .padding(.leading, geo.size.width/4)
                }
                
                
                VStack(alignment: .center, spacing: 4) {
                    
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text(buttonText)
                        .font(.system(size: 16))
                }  .frame(width: geo.size.width, height: geo.size.height)
            }
        }
        
    }
}

#Preview {
    TabBarButton(buttonText: "Chats", imageName: "bubble.left", isActive: true, buttonAction: {
        
    })
}
