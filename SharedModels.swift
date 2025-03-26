import SwiftUI
import SwiftData

enum SubjectCategory: String, CaseIterable {
    case core = "Core Subjects"
    case arts = "Arts"
    case stem = "STEM"
    case physical = "Physical Education"
    case other = "Other"
}

enum PredefinedSubject: String, CaseIterable {
    case math = "Mathematics"
    case english = "English"
    case science = "Science"
    case history = "History"
    case art = "Art"
    case music = "Music"
    case computerScience = "Computer Science"
    case physics = "Physics"
    case chemistry = "Chemistry"
    case biology = "Biology"
    case pe = "Physical Education"
    
    var name: String { rawValue }
    
    var icon: String {
        switch self {
        case .math: return "function"
        case .english: return "book"
        case .science: return "atom"
        case .history: return "clock"
        case .art: return "paintpalette"
        case .music: return "music.note"
        case .computerScience: return "laptopcomputer"
        case .physics: return "atom"
        case .chemistry: return "flask"
        case .biology: return "leaf"
        case .pe: return "figure.run"
        }
    }
    
    var color: String {
        switch self {
        case .math: return "blue"
        case .english: return "green"
        case .science: return "purple"
        case .history: return "orange"
        case .art: return "pink"
        case .music: return "red"
        case .computerScience: return "indigo"
        case .physics: return "teal"
        case .chemistry: return "mint"
        case .biology: return "green"
        case .pe: return "blue"
        }
    }
    
    var category: SubjectCategory {
        switch self {
        case .math, .english, .history:
            return .core
        case .art, .music:
            return .arts
        case .science, .computerScience, .physics, .chemistry, .biology:
            return .stem
        case .pe:
            return .physical
        }
    }
}

@Model
final class UserSubject {
    var name: String
    var icon: String
    var color: String
    var progress: Double
    var isCustom: Bool
    
    init(name: String, icon: String, color: String, progress: Double = 0.0, isCustom: Bool = false) {
        self.name = name
        self.icon = icon
        self.color = color
        self.progress = progress
        self.isCustom = isCustom
    }
} 