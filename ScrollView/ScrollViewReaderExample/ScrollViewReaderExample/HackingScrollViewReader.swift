//
//  HackingScrollViewReader.swift
//  ScrollViewReaderExample
//
//  Created by 김태성 on 8/28/24.
//

import SwiftUI

struct HackingScrollViewReader: View {
    let colors: [Color] = [.red, .green, .blue]

       var body: some View {
           ScrollViewReader { value in
               VStack {
                   Button("Jump to #8") {
                       value.scrollTo(99)
                   }
                   .padding()
               }
               
               ScrollView {
                   ForEach(0..<100) { i in
                       Text("Example \(i)")
                           .font(.title)
                           .frame(width: 200, height: 200)
                           .background(colors[i % colors.count])
                           .id(i)
                   }
               }
           }
           .frame(height: 350)
       }
}

#Preview {
    HackingScrollViewReader()
}
