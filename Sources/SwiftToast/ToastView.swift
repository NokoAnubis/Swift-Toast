//
//  ToastView.swift
//  Olympsis
//
//  Created by Joel Joseph on 7/15/23.
//

import SwiftUI

public struct ToastView: View {
    
    var content: () -> any View
    
    init(
        @ViewBuilder content: @escaping () -> any View = { EmptyView() }
    ) {
        self.content = content
    }
    
    public var body: some View {
        AnyView(content())
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.white)
                Text("Message")
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray)
                    .frame(height: 60)
            }
            .padding(.horizontal)
        }
    }
}
