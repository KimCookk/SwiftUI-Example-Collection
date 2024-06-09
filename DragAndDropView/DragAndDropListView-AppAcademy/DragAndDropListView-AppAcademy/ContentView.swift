//
//  ContentView.swift
//  DragAndDropListView-AppAcademy
//
//  Created by 김태성 on 6/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var draggedFruit: String?
    @State private var fruits: [String] = ["APPLE", "GRAPES", "BANANA", "WATERMELON", "PEACH", "KIWI", "DRAGON FRUIT"]
    
    var body: some View {
        ScrollView(showsIndicators: false, content: {
            VStack(spacing: 10, content: {
                Spacer()
                    .frame(height: 40)
                
                ForEach(fruits, id: \.self) { fruit in
                    CardItemView(title: fruit)
                        .onDrag({
                            self.draggedFruit = fruit
                            return NSItemProvider()
                        })
                        .onDrop(of: [.text], delegate: DropViewDelegate(destinationItem: fruit, fruits: $fruits, draggedItem: $draggedFruit))
                }
                
                Spacer()
            })
            .padding(.horizontal, 20)
        })
        .ignoresSafeArea()
        .background(.black)
    }
}

#Preview {
    ContentView()
}
