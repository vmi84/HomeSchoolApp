import SwiftUI

public struct AppColors {
    public static let primary = Color.blue
    public static let secondary = Color.purple
    public static let accent = Color.orange
    
    #if os(iOS) || os(visionOS)
    public static let background = Color(UIColor.systemBackground)
    public static let text = Color(UIColor.label)
    public static let textSecondary = Color(UIColor.secondaryLabel)
    #elseif os(macOS)
    public static let background = Color(NSColor.windowBackgroundColor)
    public static let text = Color(NSColor.labelColor)
    public static let textSecondary = Color(NSColor.secondaryLabelColor)
    #else
    public static let background = Color.white
    public static let text = Color.black
    public static let textSecondary = Color.gray
    #endif
} 