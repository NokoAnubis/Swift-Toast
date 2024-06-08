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
    var position: DisplayPosition
    
    public func body(content: Content) -> some View {
        switch position {
        case .top:
            return content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .top) {
                    ToastViewer()
                        .onChange(of: isPresented) { newValue in
                            guard newValue == true else {
                                return
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
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
                    ToastViewer()
                        .onChange(of: isPresented) { newValue in
                            guard newValue == true else {
                                return
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                withAnimation(.easeInOut) {
                                    isPresented = false
                                }
                            }
                        }
                }
        }
    }
    
    @ViewBuilder func ToastViewer() -> some View {
        if isPresented {
            switch position {
            case .top:
                withAnimation {
                    ToastView {
                        HStack {
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundColor(.white)
                            Text("Message")
                                .foregroundColor(.white)
                        }
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .offset(y: 15)
                    .transition(.offset(y: -1000))
                }
            case .bottom:
                withAnimation {
                    ToastView {
                        HStack {
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundColor(.white)
                            Text("Message")
                                .foregroundColor(.white)
                        }
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .offset(y: -20)
                    .transition(.offset(y: 1000))
                }
            }
        }
    }
      
}

extension View {

    public func toast(isPresented: Binding<Bool>, position: DisplayPosition) -> some View {
        self.modifier(ToastViewModifier(isPresented: isPresented, position: position))
    }
}
