//
//  UIViewRepresentable.swift
//  UIViewRepresentableExample
//
//  Created by 김태성 on 8/6/24.
//

import SwiftUI

struct CustomUIViewRepresentable: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text(text)
            
            HStack {
                Text("Switft UI : ")
                TextField("Type Here...", text: $text)
                    .frame(height: 55)
                    .background(Color.gray)
            }.padding()
            
            HStack {
                Text("UI Kit : ")
                UITextFieldViewRepresentable(text: $text)
                    .updatePlaceholder("New placeHolder!")
                    .frame(height: 55)
                    .background(Color.gray)
            }.padding()
            
            
        }
        
    }
}

#Preview {
    CustomUIViewRepresentable()
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    let palceholderColor: UIColor
    
    init(text: Binding<String>,
         placeholder: String = "",
         palceholderColor: UIColor = .blue) {
        
        self._text = text
        self.placeholder = placeholder
        self.palceholderColor = palceholderColor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        
        return textField
    }
    
    // from SwiftUI to UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        
        let placeholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor : palceholderColor
            ])
        
        textField.attributedPlaceholder = placeholder
        // textField.delegate
        return textField
    }
    
    // from UIkit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func updatePlaceholder(_ text: String) ->  UITextFieldViewRepresentable{
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context content: Context) {
        
    }
}
