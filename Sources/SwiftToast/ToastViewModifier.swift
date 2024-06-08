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
    @Binding var toastContent: () -> any View
    
    public func body(content: Content) -> some View {
        switch position {
        case .top:
            return content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .top) {
                    AnyView(toastContent())
                        .onChange(of: isPresented) { newValue in
                            guard newValue == true else {
                                return
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                withAnimation(.easeInOut) {
                                    isPresented = false
                                }
                            }
                        }
                }
        case .bottom:
            return content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .bottom) {
                    AnyView(toastContent())
                        .onChange(of: isPresented) { newValue in
                            guard newValue == true else {
                                return
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                withAnimation(.easeInOut) {
                                    isPresented = false
                                }
                            }
                        }
                }
        }
    }
}

extension View {

    public func toast(isPresented: Binding<Bool>, position: Binding<DisplayPosition>, content: Binding<() -> any View>) -> some View {
        self.modifier(ToastViewModifier(isPresented: isPresented, position: position, toastContent: content))
    }
}
