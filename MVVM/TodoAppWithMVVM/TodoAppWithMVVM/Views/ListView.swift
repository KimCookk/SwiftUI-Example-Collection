//
//  ListView.swift
//  TodoAppWithMVVM
//
//  Created by 김태성 on 5/8/24.
//

import SwiftUI

struct ListView: View {
    
    @State var items: [String] = [
        "This is the first Item!",
        "This is the second!",
        "Third"
    ]
    
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                ListRowView(title: item)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Todo List 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: AddView())
        )
    }
}

#Preview {
    NavigationView {
        ListView()
    }
}
