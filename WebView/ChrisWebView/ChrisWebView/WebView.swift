//
//  WebView.swift
//  ChrisWebView
//
//  Created by 김태성 on 6/1/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: URL?
    
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {

        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
