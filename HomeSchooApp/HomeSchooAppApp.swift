import SwiftUI
import SwiftData

// Stub Firebase for development
enum FirebaseApp {
    static func configure() {
        print("Firebase configuration stubbed for development")
    }
}

@main
struct HomeSchooAppApp: App {
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

// Authentication Service Stub
class AuthenticationService: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated = false
    @Published var error: Error?
    
    // Stub User class for development
    class User {
        let uid: String
        let email: String?
        
        init(uid: String, email: String?) {
            self.uid = uid
            self.email = email
        }
    }
    
    init() {
        // For development: Create a mock user
        self.user = User(uid: "test-uid", email: "test@example.com")
        self.isAuthenticated = true
    }
    
    func signIn(email: String, password: String) {
        // Mock authentication for development
        self.user = User(uid: "test-uid", email: email)
        self.isAuthenticated = true
    }
    
    func signOut() {
        // Mock sign out
        self.user = nil
        self.isAuthenticated = false
    }
} 