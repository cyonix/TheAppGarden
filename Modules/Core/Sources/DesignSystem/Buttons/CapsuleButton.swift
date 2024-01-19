//
//  Created by Austin Ugbeme on 1/19/24.
//

import SwiftUI

public struct CapsuleButton: View {
    public let text: String
    public let font: Font
    public let foregroundColor: Color
    public let strokeColor: Color
    public var onTap: () -> Void

    public init(
        text: String,
        font: Font = .AppGarden.caption,
        foregroundColor: Color = .AppGarden.placeholder,
        strokeColor: Color = .AppGarden.emphasis,
        onTap: @escaping () -> Void
    ) {
        self.text = text
        self.font = font
        self.foregroundColor = foregroundColor
        self.strokeColor = strokeColor
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: onTap) {
            Text(text)
                .font(font)
                .foregroundColor(foregroundColor)
                .padding(.vertical, Sizes.small)
                .padding(.horizontal, Sizes.medium)
        }
        .background(Color.clear)
        .clipShape(Capsule())
        .overlay(
            Capsule().stroke(strokeColor, lineWidth: 1)
        )

    }
}

#Preview {
    CapsuleButton(
        text: "Culture",
        onTap: {}
    )
}
