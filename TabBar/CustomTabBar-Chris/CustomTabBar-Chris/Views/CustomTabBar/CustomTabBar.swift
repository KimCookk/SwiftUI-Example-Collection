//
//  CustomTabBar.swift
//  CustomTabBar-Chris
//
//  Created by 김태성 on 4/30/24.
//

import SwiftUI

enum Tabs: Int {
    case chats = 0
    case contacts = 1
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 30) {
            
            TabBarButton(buttonText: "Chats",
                         imageName: "bubble.left",
                         isActive: selectedTab == .chats,
                         buttonAction: {
                selectedTab = .chats

            })
            .tint(.gray)
            
            Button(action: {
                
            }, label: {
                
                VStack(alignment: .center, spacing: 5) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    
                    Text("New Chat")
                        .font(.system(size: 16))
                }
                
            })
            .tint(.blue)
            
            
            TabBarButton(buttonText: "Contacts",
                         imageName: "person",
                         isActive: selectedTab == .contacts,
                         buttonAction: {
                selectedTab = .contacts

            })
            .tint(.gray)
            
//            Button(action: {
//                
//                selectedTab = .contacts
//                
//            }, label: {
//                GeometryReader { geo in
//                    
//                    if(selectedTab == .contacts) {
//                        Rectangle()
//                            .foregroundColor(.blue)
//                            .frame(width: geo.size.width/2, height: 4)
//                            .padding(.leading, geo.size.width/4)
//                    }
//                    
//                    
//                    VStack(alignment: .center, spacing: 4) {
//                        
//                        Image(systemName: "person")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 24, height: 24)
//                        
//                        Text("Contacts")
//                            .font(.system(size: 16))
//                    }  .frame(width: geo.size.width, height: geo.size.height)
//                }
//            })
//            .tint(.gray)
        }
        .frame(height: 82)
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.contacts))
}
