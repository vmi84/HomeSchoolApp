import SwiftUI
import SwiftData

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
        // Create a test user for development
        let service = AuthenticationService()
        service.user = AuthenticationService.AuthUser(uid: "test-user", email: "test@example.com")
        service.isAuthenticated = true
        _authService = StateObject(wrappedValue: service)
    }
    
    var body: some Scene {
        WindowGroup {
            if authService.isAuthenticated {
                ContentView()
                    .modelContainer(sharedModelContainer)
                    .environmentObject(authService)
            } else {
                WelcomeView()
                    .environmentObject(authService)
            }
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