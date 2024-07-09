//
//  ContentView.swift
//  DragAndDropImageView
//
//  Created by 김태성 on 6/15/24.
//

import SwiftUI

struct ContentView: View {
    @State var items = [Image(uiImage: UIImage(systemName: "person")!), Image(uiImage: UIImage(systemName: "photo")!), Image(uiImage: UIImage(systemName: "heart")!), Image(uiImage: UIImage(systemName: "pill")!)]
    
    @State var draggedItem: Image?
    
    var body: some View {
        VStack(spacing: 20) {
            //            ForEach(items, id: \.self) { item in
            //                Image(uiImage: item!)
            //                    .resizable()
            //                    .frame(width: 100, height: 100)
            //                    .onDrag {
            //                        self.draggedItem = item
            //                        return NSItemProvider()
            //                    }
            //                    .onDrop(
            //                        of: [.image],
            //                        delegate: DropViewDelegate(
            //                            item: item!,
            //                            items: $items,
            //                            draggedItem: $draggedItem
            //                        )
            //                    )
            //            }
            
            
                items[0]
                    .resizable()
                    .frame(width: 100, height: 100)
                    .onDrag {
                        self.draggedItem = items[0]
                        return NSItemProvider()
                    }
                    .onDrop(
                        of: [.image],
                        delegate: DropViewDelegate(
                            item: items[0],
                            items: $items,
                            draggedItem: $draggedItem
                        )
                    )
            
            items[0]
                .resizable()
                .frame(width: 100, height: 100)
                .onDrag {
                    self.draggedItem = items[1]
                    return NSItemProvider()
                }
                .onDrop(
                    of: [.image],
                    delegate: DropViewDelegate(
                        item: items[1],
                        items: $items,
                        draggedItem: $draggedItem
                    )
                )
        
            
        }
    }
}

#Preview {
    ContentView()
}


struct DropViewDelegate: DropDelegate {
    
    let item: Image
    @Binding var items: [Image]
    @Binding var draggedItem: Image?
    
    // 드래그 할 때 아이템 우측 상단에 표시되는 이미지 설정 (이 매서드 아예 안쓰면 기본 값 copy : + 플러스 이미지)
    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move) // move, cancel 은 이미지 안나옴. forbidden 는 ⛔︎ 이런 이미지 나옴
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        guard let draggedItem,
              draggedItem != item,
              let to = items.firstIndex(of: item),
              let from = items.firstIndex(of: draggedItem) else { return }
        
        withAnimation {
            items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
        }
    }
}
