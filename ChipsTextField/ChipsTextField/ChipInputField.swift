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
            
            CustomTextFieldWrapper(inputText: $inputText,
                                   placeholder: placeholder,
                                   onSubmit: {
                self.addChip(inputText)
                inputText = ""
            }, onChange: { oldValue, newValue in
                if(inputText.hasSuffix(" ") && newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false) {
                    print(String(inputText[..<inputText.index(before: inputText.endIndex)]))
                    self.addChip(String(inputText[..<inputText.index(before: inputText.endIndex)]))
                    inputText = ""
                }
            }, onDelete: { oldValue, newValue in
                if !chips.isEmpty && (oldValue.isEmpty == true && newValue.isEmpty == true) {
                    let last = chips.removeLast()
                    inputText = last
                }
            })
            .lineLimit(1)
            
            
            
            //                .onSubmit(of: .text) {
            //                    self.addChip(inputText)
            //                    inputText = ""
            //                }
            //                .onChange(of: inputText) { oldValue, newValue in
            //                    if(inputText.hasSuffix(" ") && newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false) {
            //                        print(String(inputText[..<inputText.index(before: inputText.endIndex)]))
            //                        self.addChip(String(inputText[..<inputText.index(before: inputText.endIndex)]))
            //                        inputText = ""
            //                    }
            //                    else if !chips.isEmpty && (oldValue.isEmpty == true && newValue.isEmpty == true) {
            //                        let last = chips.removeLast()
            //                        inputText = last
            //                    }
            //                }
            
            
            //            TextField(placeholder, text: $inputText)
            //                .lineLimit(1)
            //                .onSubmit(of: .text) {
            //                    self.addChip(inputText)
            //                    inputText = ""
            //                }
            //                .onChange(of: inputText) { oldValue, newValue in
            //                    if(inputText.hasSuffix(" ") && newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false) {
            //                        print(String(inputText[..<inputText.index(before: inputText.endIndex)]))
            //                        self.addChip(String(inputText[..<inputText.index(before: inputText.endIndex)]))
            //                        inputText = ""
            //                    }
            //                    else if !chips.isEmpty && (oldValue.isEmpty == true && newValue.isEmpty == true) {
            //                        let last = chips.removeLast()
            //                        inputText = last
            //                    }
            //                }
        }
    }
    
    func addChip(_ chip: String) {
        if(!chips.contains(chip)) {
            chips.append(chip)
        }
    }
}

#Preview {
    ChipInputField(chips: Binding.constant(["test"]),
                   placeholder: "Enter tag")
}
