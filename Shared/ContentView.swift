//
//  ContentView.swift
//  Shared
//
//  Created by João de Vasconcelos on 04/02/2022.
//


import SwiftUI


struct ContentView: View {
  @StateObject var webViewStore = WebViewStore()

  var body: some View {
      WebView(webView: webViewStore.webView)
      .onAppear {
        self.webViewStore.webView.load(URLRequest(url: URL(string: "https://pos-terminal.vercel.app")!))
      }
  }
}


