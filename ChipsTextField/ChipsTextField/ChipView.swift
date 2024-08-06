//
//  ChipView.swift
//  ChipsTextField
//
//  Created by 김태성 on 8/4/24.
//

import SwiftUI

struct ChipView: View {
    let text: String
    let onDelete: (String) -> Void
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 12))
                .fontWeight(.bold)
                .lineLimit(1)
            
            Button {
                onDelete(text)
            } label: {
                Image(systemName: "x.circle")
                    .foregroundColor(.black)
                    .frame(width: 16, height: 16)
            }
        }
        .padding(4)
        .background(RoundedRectangle(cornerRadius: 10))
        .foregroundColor(.gray.opacity(0.5))
    }
}

#Preview {
    ChipView(text: "Test",
             onDelete: { String in
        
    })
}
