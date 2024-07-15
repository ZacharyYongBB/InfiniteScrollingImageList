//
//  PrimaryButton.swift
//  InfiniteScrollingImageList
//
//  Created by Zachary on 16/7/24.
//

import SwiftUI

struct PrimaryButton: ViewModifier {
    var width: CGFloat
    var backgroundColor: Color
    var foregroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: .infinity)
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(8)
            .font(.headline)
    }
}

extension View {
    func primaryButton(width: CGFloat = .infinity, backgroundColor: Color = .blue, foregroundColor: Color = .white) -> some View {
        self.modifier(PrimaryButton(width: width, backgroundColor: backgroundColor, foregroundColor: foregroundColor))
    }
}
