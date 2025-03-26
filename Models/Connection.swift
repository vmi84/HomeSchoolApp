import Foundation
import SwiftUI

struct Connection: Identifiable {
    let id = UUID()
    let name: String
    let type: ConnectionType
    let bio: String?
    let subjects: [String]?
    
    enum ConnectionType: String, CaseIterable, Identifiable {
        case tutor
        case parent
        case group
        
        var id: String { rawValue }
        
        var icon: String {
            switch self {
            case .tutor: return "person.fill.viewfinder"
            case .parent: return "person.2.fill"
            case .group: return "person.3.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .tutor: return .blue
            case .parent: return .green
            case .group: return .purple
            }
        }
    }
} 