//
//  CardItemView.swift
//  DragAndDropListView-AppAcademy
//
//  Created by 김태성 on 6/9/24.
//

import SwiftUI

struct CardItemView: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
            Spacer()
        }
        .padding(.vertical, 40)
        .background(.yellow)
        .cornerRadius(20)
    }
}

#Preview {
    CardItemView(title: "Apple")
}
