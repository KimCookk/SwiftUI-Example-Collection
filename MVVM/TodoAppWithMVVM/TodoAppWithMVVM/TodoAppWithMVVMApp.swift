//
//  TodoAppWithMVVMApp.swift
//  TodoAppWithMVVM
//
//  Created by 김태성 on 5/8/24.
//

import SwiftUI

/*
 
 MVVM Architecture
 
 Model - Data point
 View - UI
 ViewModel - Manages Model for View
 
 */
@main
struct TodoAppWithMVVMApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
