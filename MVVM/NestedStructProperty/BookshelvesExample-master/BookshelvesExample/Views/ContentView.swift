//
//  ContentView.swift
//  BookshelvesExample
//
//  Created by George Elsham on 26/01/2020.
//  Copyright © 2020 George Elsham. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject private var model: BookshelvesModel
    @State private var newItem: String = ""
    @State private var isAdd: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(model.shelves, id: \.id) { shelf in
                    NavigationLink(destination: BookEditView(shelfId: shelf.id)) {
                        HStack {
                            Text(shelf.title)
                            Spacer()
                            Text(model.totalBooks(for: shelf))
                        }
                    }
                }
                
                if(isAdd) {
                    TextField("New Shelf", text: $newItem, onCommit: {
                        if !newItem.isEmpty {
                            model.addShelf(title: newItem)
                            isAdd = false
                        }
                    })
                }
            }
            .navigationBarTitle("Shelves")
            .navigationBarItems(
                trailing:
                    HStack {
                        Button(
                            action: {
                                newItem.removeAll()
                                isAdd = true
                            },
                            label: {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                            }
                        )
                        
                        
                        Button(
                            action: {
                                model.updateShelf()
                            },
                            label: {
                                Image(systemName: "arrow.clockwise")
                                    .imageScale(.large)
                            }
                        )
                    }
            )
        }
    }
}
