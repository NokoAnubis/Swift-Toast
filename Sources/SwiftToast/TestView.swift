//
//  SwiftUIView.swift
//  SwiftToast
//
//  Created by Joel Joseph on 8/24/24.
//

import SwiftUI

struct TestView: View {
    
    @State private var isPresented = false
    @State private var content: () -> any View = {
        RoundedRectangle(cornerRadius: 10)
            .frame(height: 70)
            .padding(.horizontal)
            .foregroundStyle(.gray)
            .overlay {
                Text("This is a toast message.")
            }
    }
    @State private var position = DisplayPosition.top
    
    var body: some View {
        Group {
            Button(action: {
                withAnimation(.easeInOut) {
                    self.isPresented = true
                }
            }) {
                Text("Show Toast")
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .toast(isPresented: $isPresented, position: $position, content: $content)
    }
}

#Preview {
    TestView()
}
