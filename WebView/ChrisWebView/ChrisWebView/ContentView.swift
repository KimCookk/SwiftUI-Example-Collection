//
//  ContentView.swift
//  ChrisWebView
//
//  Created by 김태성 on 6/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WebView(url: URL(string: "https://www.naver.com"))
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
