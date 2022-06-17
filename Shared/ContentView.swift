//
//  ContentView.swift
//  Shared
//
//  Created by João de Vasconcelos on 04/02/2022.
//


import SwiftUI


//struct ContentView: View {
//
//    let character_limit = 6
//
//    @State private var deviceCode: String = ""
//
//    var body: some View {
//        VStack {
//            TextField("Device Code", text: $deviceCode)
//                .font(.system(size: 100))
//                .multilineTextAlignment(.center)
//                .disableAutocorrection(true)
//                .padding()
//                .textFieldStyle(.plain)
//                .onChange(of: self.deviceCode, perform: { value in
//                    self.deviceCode = String(deviceCode.prefix(character_limit)).uppercased()
//                })
//        }
//    }
//}

struct ContentView: View {
    
    @State private var showWebView = false
    
    var body: some View {
//        WebView(url: URL(string: "http://192.168.4.51:3000")!)
        WebView(url: URL(string: "https://pos.chefpoint.pt/")!)
    }

}


