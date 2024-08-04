//
//  ContentView.swift
//  ChipsTextField
//
//  Created by 김태성 on 8/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var chips: [String] = ["some"]
    
    var body: some View {
       ChipInputField(chips: $chips, placeholder: "Tags Enter")
    }
}

#Preview {
    ContentView()
}
