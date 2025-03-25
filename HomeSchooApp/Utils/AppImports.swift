import SwiftUI
import SwiftData

// Stub Firebase Core
#if DEBUG
enum FirebaseApp {
    static func configure() {
        print("Firebase configured (stub)")
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
        // Mock user for testing
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
#endif 