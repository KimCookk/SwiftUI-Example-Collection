//
//  ListRowVIew.swift
//  TodoAppWithMVVM
//
//  Created by 김태성 on 5/8/24.
//

import SwiftUI

struct ListRowView: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle")
            Text(title)
            Spacer()
        }
    }
}

#Preview {
    ListRowView(title: "This is the first Item!")
}
