//
//  PrimaryButton.swift
//  InfiniteScrollingImageList
//
//  Created by Zachary on 16/7/24.
//

import SwiftUI

struct PrimaryButton: ViewModifier {
    var backgroundColor: Color
    var foregroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(8)
            .font(.headline)
    }
}

extension View {
    func primaryButton(backgroundColor: Color = .blue, foregroundColor: Color = .white) -> some View {
        self.modifier(PrimaryButton(backgroundColor: backgroundColor, foregroundColor: foregroundColor))
    }
}
