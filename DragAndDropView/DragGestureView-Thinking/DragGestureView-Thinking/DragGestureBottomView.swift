//
//  DragGestureBottomView.swift
//  DragGestureView-Thinking
//
//  Created by 김태성 on 6/13/24.
//

import SwiftUI

struct DragGestureBottomView: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingDragOffsetY: CGFloat = 0

    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            MySignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingDragOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring) {
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring) {
                                if currentDragOffsetY < -150 {
                                    endingDragOffsetY = -startingOffsetY
                                } else if endingDragOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingDragOffsetY = 0
                                }
                                currentDragOffsetY = 0

                            }
                        }
                
                )
            
            Text("\(currentDragOffsetY)")
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    DragGestureBottomView()
}

struct MySignUpView: View {
    var body: some View {
        VStack {
            Image(systemName: "chevron.up")
                .padding(.top)
            
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the decription for our app, This is my favorite SwiftUI course and i recomended to all 이것은 설명을 위한 예시 앱입니다. 하잇!")
                .multilineTextAlignment(.center)
            
            Text("CREATE AN ACCOUNT")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}
