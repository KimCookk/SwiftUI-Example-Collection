//
//  ContentView.swift
//  CurevedTabBar-Kavsoft
//
//  Created by 김태성 on 6/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var index: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
         
            ZStack {
                if self.index == 0 {
                    Color.red

                } else if self.index == 1 {
                    Color.blue
                    
                } else if self.index == 2 {
                    Color.green
                    
                } else if self.index == 3 {
                    Color.gray
                }
            }
            .edgesIgnoringSafeArea(.top)
            .padding(.bottom, -35)
            
            TabView(index: self.$index)
        }
        .background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.top))
    }
}

#Preview {
    ContentView()
}

struct TabView: View {
    
    @Binding var index: Int
    
    var body: some View {
        HStack {
            Button(action: {
                self.index = 0
            }) {
                Image(systemName: "house")
            }
            .foregroundColor(Color.black.opacity(self.index == 0 ? 1 : 0.3))
            .padding(10)
            
            Spacer(minLength: 0)
            
            Button(action: {
                self.index = 1

            }) {
                Image(systemName: "magnifyingglass")
            }
            .foregroundColor(Color.black.opacity(self.index == 1 ? 1 : 0.3))
            .padding(10)
            
            Spacer(minLength: 0)
            
            Button(action: {
                
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .offset(y: -25)
            
            Spacer(minLength: 0)
            
            Button(action: {
                self.index = 2

            }) {
                Image(systemName: "heart")
            }
            .foregroundColor(Color.black.opacity(self.index == 2 ? 1 : 0.3))
            .padding(10)
            
            Spacer(minLength: 0)
            
            Button(action: {
                self.index = 3

            }) {
                Image(systemName: "person")
            }
            .foregroundColor(Color.black.opacity(self.index == 3 ? 1 : 0.3))
            .padding(10)
        }
        .padding(.horizontal, 35)
        .padding(.top, 35)
        .background(Color.white)
        .clipShape(CShape())
    }
}

struct CShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 35))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 35))
            
            path.addArc(center: CGPoint(x: (rect.width/2) + 2, y: 35), radius: 35, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
        }
    }
}
