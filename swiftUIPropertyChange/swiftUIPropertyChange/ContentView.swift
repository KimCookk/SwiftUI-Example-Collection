//
//  ContentView.swift
//  swiftUIPropertyChange
//
//  Created by 김태성 on 10/2/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel {
        willSet(newValue) {
            print("viewModel willSet");
        }
        didSet {
            print("viewModel didSet");
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("\(viewModel.unitClassModel.name) \(viewModel.unitClassModel.content)")
                
                Text("\(viewModel.unitStructModel.name) \(viewModel.unitStructModel.content)")
                
                
                ForEach(viewModel.unitClassModelArray) { classModel in
                    Text("\(classModel.name) \(classModel.content)")
                }
//                
                ForEach(viewModel.unitStructModelArray) { structModel in
                    Text("\(structModel.name) \(structModel.content)")
                }
            }
            .background(Color.gray)
            .padding(.horizontal, 5)
            
            
            VStack {
                Button(action: {
                    viewModel.unitClassModelChange()
                }, label: {
                    Text("UnitClassModel property Change")
                })
                
                Button(action: {
                    viewModel.unitStructModelChange()
                }, label: {
                    Text("UnitStructModel property Change")
                })
                
                Button(action: {
                    viewModel.unitClassModelArrayRandomChange()
                }, label: {
                    Text("UnitClassModelArray index 1 Change")
                })
                
                Button(action: {
                    viewModel.unitStructModelArrayRandomChange()
                }, label: {
                    Text("UnitStructModelArray index 1 Change")
                })
                
                Button(action: {
                    viewModel.unitClassModelArrayAdd()
                }, label: {
                    Text("UnitClassModelArray add")
                })
                
                Button(action: {
                    viewModel.unitStructModelArrayAdd()
                }, label: {
                    Text("UnitStructModelArray add")
                })
            }
            .background(Color.gray)
            .padding(.horizontal, 5)
            
        }
        
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
