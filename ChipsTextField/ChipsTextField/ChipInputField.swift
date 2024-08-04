//
//  ChipInputField.swift
//  ChipsTextField
//
//  Created by 김태성 on 8/4/24.
//

import SwiftUI

struct ChipInputField: View {
    @Binding var chips: [String]
    let placeholder: String
    
    @State private var inputText = ""
    
    var body: some View {
        HStack {
            ForEach(chips, id: \.self) { chip in
                ChipView(text: chip) { text in
                    chips.removeAll(where: {
                        $0 == text
                    })
                }
            }
            
            TextField(placeholder, text: $inputText)
                .onSubmit(of: .text) {
                    chips.append(inputText)
                    inputText = ""
                    
                }
                .onChange(of: inputText) { _ in
                    if(inputText.hasSuffix(" ")) {
                        chips.append(String(inputText[..<inputText.index(before: inputText.endIndex)]))
                                    inputText = ""
                    } else if !chips.isEmpty && inputText.isEmpty {
                        let last = chips.removeLast()
                        inputText = last
                    }
                }
        }
        .underline()
    }
}

#Preview {
    ChipInputField(chips: Binding.constant(["test"]),
                   placeholder: "Enter tag")
}
