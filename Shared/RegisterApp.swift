//
//  RegisterApp.swift
//  Shared
//
//  Created by João de Vasconcelos on 04/02/2022.
//

import SwiftUI

@main
struct RegisterApp: App {
    
    @State var skipSetup: Bool
    @State var inputValue: String
    
    let defaults = UserDefaults.standard
    
    // -
    
    init() {
        // Retrieve device_code from User Defaults
        let deviceCode = defaults.string(forKey: "device_code") ?? "invalid_device_code"
        // Set device_code to be the input value
        inputValue = deviceCode
        // If device_code is invalid, show setup view
        skipSetup = deviceCode != "invalid_device_code"
    }
    
    func saveDeviceCode(value: String) {
        defaults.set(value, forKey: "device_code")
    }
    
    // -
    
    var body: some Scene {
        WindowGroup {
            if (skipSetup) {
                // POS App
                WebView(url: URL(string: "https://pos.chefpoint.pt/?device_code=" + inputValue)!)
                    .onShake {
                        skipSetup = false
                    }
            } else {
                // Setup Device
                VStack {
                    TextField("Device Code", text: $inputValue)
                        .textFieldStyle(.roundedBorder)
                        .font(.system(size: 100))
                        .multilineTextAlignment(.center)
                        .padding(50)
                    Button("Confirm Device Code") {
                        saveDeviceCode(value: inputValue)
                        skipSetup = true
                    }
                    .buttonStyle(.borderedProminent)
                    .font(.system(size: 30))
                }
            }
            
        }
    }
}


// Shake Gesture Notifications:

// The notification we'll send when a shake gesture happens.
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//  Override the default behavior of shake gestures to send our notification instead.
extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}

// A view modifier that detects shaking and calls a function of our choosing.
struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

// A View extension to make the modifier easier to use.
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}
