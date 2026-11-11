
import SwiftUI
import UIKit

enum AppColors {

    // MARK: - Background

    static let background = dynamicColor(
        dark: 0x000000,
        light: 0xFFFFFF
    )

    // MARK: - Surfaces

    static let surface = dynamicColor(
        dark: 0x18181D,
        light: 0xF1F1F4
    )

    static let surfaceSecondary = dynamicColor(
        dark: 0x222224,
        light: 0xE5E5E9
    )

    // MARK: - Text Colors

    static let primaryText = dynamicColor(
        dark: 0xFFFFFF,
        light: 0x171717
    )

    static let secondaryText = dynamicColor(
        dark: 0x8E8E93,
        light: 0x68686E
    )

    static let mutedText = dynamicColor(
        dark: 0x989898,
        light: 0x77777D
    )

    // MARK: - Accent Colors

    static let primary = Color(hex: 0x26C391)
    static let mint = Color(hex: 0x28E0A8)

    static let sunlight = dynamicColor(
        dark: 0xCEDE89,
        light: 0x718A16
    )

    static let water = dynamicColor(
        dark: 0xCAF3FB,
        light: 0x168BA3
    )

    // MARK: - Divider

    static let divider = dynamicColor(
        dark: 0x444444,
        light: 0xDDDDDD
    )

    // MARK: - Dynamic Color

    private static func dynamicColor(
        dark: UInt32,
        light: UInt32
    ) -> Color {

        Color(
            uiColor: UIColor { traits in

                let hex = traits.userInterfaceStyle == .dark
                    ? dark
                    : light

                return UIColor(
                    red: CGFloat((hex >> 16) & 0xFF) / 255,
                    green: CGFloat((hex >> 8) & 0xFF) / 255,
                    blue: CGFloat(hex & 0xFF) / 255,
                    alpha: 1
                )
            }
        )
    }
}

// MARK: - Hex Color

extension Color {

    init(hex: UInt32) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: 1
        )
    }
}
