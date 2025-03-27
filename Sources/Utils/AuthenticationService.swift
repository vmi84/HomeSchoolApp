import Foundation
import SwiftUI
import FirebaseAuth
import GoogleSignIn

@MainActor
final class AuthenticationService: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated = false
    @Published var error: Error?
    
    // Stub User class for development
    final class User {
        let uid: String
        let email: String?
        let displayName: String?
        
        init(uid: String, email: String?, displayName: String? = nil) {
            self.uid = uid
            self.email = email
            self.displayName = displayName
        }
    }
    
    init() {
        // For development: Start with no user
        self.user = nil
        self.isAuthenticated = false
    }
    
    func signIn(email: String, password: String) async throws {
        // Mock authentication for development
        DispatchQueue.main.async {
            self.user = User(uid: "test-uid", email: email)
            self.isAuthenticated = true
        }
    }
    
    func signUp(email: String, password: String, name: String) async throws {
        // Mock registration for development
        DispatchQueue.main.async {
            self.user = User(uid: "test-uid", email: email, displayName: name)
            self.isAuthenticated = true
        }
    }
    
    func signInWithGoogle() async throws {
        // Mock Google sign in for development
        DispatchQueue.main.async {
            self.user = User(uid: "google-uid", email: "google@example.com", displayName: "Google User")
            self.isAuthenticated = true
        }
    }
    
    func signOut() {
        self.user = nil
        self.isAuthenticated = false
    }
    
    func developerBypass() {
        self.user = User(uid: "dev-uid", email: "dev@example.com", displayName: "Developer")
        self.isAuthenticated = true
    }
} 