import SwiftUI
import SwiftData
import Charts

// MARK: - Models

@Model
final class UserSubject: Identifiable {
    var id: UUID
    var name: String
    var icon: String
    var color: String
    var progress: Double
    var isCustom: Bool
    
    init(name: String, icon: String, color: String, progress: Double = 0.0, isCustom: Bool = false) {
        self.id = UUID()
        self.name = name
        self.icon = icon
        self.color = color
        self.progress = progress
        self.isCustom = isCustom
    }
}

enum SubjectCategory: String, Codable, CaseIterable {
    case general = "General"
    case math = "Math"
    case science = "Science"
    case language = "Language Arts"
    case history = "History"
    case art = "Art"
    case music = "Music"
    case physical = "Physical Education"
    
    var icon: String {
        switch self {
        case .general: return "folder"
        case .math: return "function"
        case .science: return "atom"
        case .language: return "book"
        case .history: return "clock"
        case .art: return "paintpalette"
        case .music: return "music.note"
        case .physical: return "figure.run"
        }
    }
    
    var color: String {
        switch self {
        case .general: return "gray"
        case .math: return "blue"
        case .science: return "green"
        case .language: return "purple"
        case .history: return "orange"
        case .art: return "pink"
        case .music: return "red"
        case .physical: return "indigo"
        }
    }
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
        case .math:
            return .math
        case .english:
            return .language
        case .history:
            return .history
        case .art:
            return .art
        case .music:
            return .music
        case .science, .computerScience, .physics, .chemistry, .biology:
            return .science
        case .pe:
            return .physical
        }
    }
}

// MARK: - Firebase Stubs

enum FirebaseApp {
    static func configure() {
        print("Firebase configuration stubbed for development")
    }
}

class AuthenticationService: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated = false
    @Published var error: Error?
    
    class User {
        let uid: String
        let email: String?
        
        init(uid: String, email: String?) {
            self.uid = uid
            self.email = email
        }
    }
    
    init() {
        self.user = User(uid: "test-uid", email: "test@example.com")
        self.isAuthenticated = true
    }
    
    func signIn(email: String, password: String) {
        self.user = User(uid: "test-uid", email: email)
        self.isAuthenticated = true
    }
    
    func signOut() {
        self.user = nil
        self.isAuthenticated = false
    }
}

// MARK: - Main App

@main
struct PETS_app: App {
    @StateObject private var authService = AuthenticationService()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserSubject.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(sharedModelContainer)
                .environmentObject(authService)
        }
    }
}

// MARK: - Core Views

struct ContentView: View {
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
            ResourcesView()
                .tabItem {
                    Label("Resources", systemImage: "folder")
                }
            
            ConnectionsView()
                .tabItem {
                    Label("Connections", systemImage: "person.2")
                }
            
            StudentProgressView()
                .tabItem {
                    Label("Progress", systemImage: "chart.bar")
                }
        }
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            Text("Learning Compass")
                .navigationTitle("Profile")
        }
    }
}

struct ResourcesView: View {
    var body: some View {
        NavigationStack {
            Text("Resource Nexus")
                .navigationTitle("Resources")
        }
    }
}

struct ConnectionsView: View {
    var body: some View {
        NavigationStack {
            Text("HomeLink")
                .navigationTitle("Connections")
        }
    }
}

struct StudentProgressView: View {
    var body: some View {
        NavigationStack {
            Text("GrowEasy Analytics")
                .navigationTitle("Progress")
        }
    }
}

struct SubjectPickerView: View {
    var body: some View {
        NavigationStack {
            Text("Add Subject")
                .navigationTitle("Subject Picker")
        }
    }
}

struct CustomSubjectView: View {
    var body: some View {
        NavigationStack {
            Text("Create Custom Subject")
                .navigationTitle("Custom Subject")
        }
    }
} 