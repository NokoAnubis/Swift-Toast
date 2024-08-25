//
//  ToastViewModifier.swift
//  Olympsis
//
//  Created by Joel Joseph on 7/16/23.
//

import SwiftUI
import Foundation

public struct ToastViewModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    @Binding var position: DisplayPosition
    @Binding var toastContent: ToastContent
    @Environment(\.openURL) private var openURL
    
    var delay: TimeInterval = 4.0
    
    @State private var timerWorkItem: DispatchWorkItem?
    
    private func hideToast() {
        isPresented = false
    }
    
    private func resetTimer() {
         // Cancel the previous work item if it exists
         timerWorkItem?.cancel()
         
         // Create a new DispatchWorkItem
         let workItem = DispatchWorkItem {
             hideToast()
         }
         
         // Assign the new work item
         timerWorkItem = workItem
         
         // Dispatch the work item after the delay
         DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
     }
    
    public func body(content: Content) -> some View {
        switch position {
        case .top:
            return content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .top) {
                    Group {
                        if isPresented {
                            AnyView(toastContent.view())
                                .zIndex(10)
                        }
                    }
                }
                .onChange(of: isPresented) { newValue in
                    guard newValue == true else {
                        return
                    }
                    resetTimer()
                }
                .onTapGesture {
                    if let url = toastContent.url {
                        openURL(url)
                    }
                    hideToast()
                }
        case .bottom:
            return content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .bottom) {
                    Group {
                        if isPresented {
                            AnyView(toastContent.view())
                                .zIndex(10)
                        }
                    }
                }
                .onChange(of: isPresented) { newValue in
                    guard newValue == true else {
                        return
                    }
                    resetTimer()
                }
                .onTapGesture {
                    if let url = toastContent.url {
                        openURL(url)
                    }
                    hideToast()
                }
        }
    }
}

extension View {
    public func toast(isPresented: Binding<Bool>, position: Binding<DisplayPosition>, content: Binding<ToastContent>) -> some View {
        self.modifier(ToastViewModifier(isPresented: isPresented, position: position, toastContent: content))
    }
}
