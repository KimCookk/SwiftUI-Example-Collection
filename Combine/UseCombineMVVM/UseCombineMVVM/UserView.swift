//
//  UserView.swift
//  UseCombineMVVM
//
//  Created by 김태성 on 7/6/24.
//

import SwiftUI

struct UserView: View {
    @StateObject var viewModel: UserViewModel
    
    var body: some View {
        VStack {
            TextField("Enter name", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Text("User name is: \(viewModel.user.name)")
                .padding()
        }
    }
}

struct ContentView: View {
    var body: some View {
        let user = User(name: "John Doe")
        let viewModel = UserViewModel(user: user)
        
        UserView(viewModel: viewModel)
    }
}
