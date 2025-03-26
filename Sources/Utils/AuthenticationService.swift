import Foundation
import SwiftUI

final class AuthenticationService: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated = false
    @Published var error: Error?
    
    // Stub User class for development
    final class User {
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
    
    func signUp(email: String, password: String, name: String) async throws {
        // TODO: Implement actual user registration
        // For now, we'll just simulate a successful registration
        DispatchQueue.main.async {
            self.isAuthenticated = true
            self.user = User(uid: "1", email: email)
        }
    }
    
    func developerBypass() {
        self.user = User(uid: "dev-uid", email: "dev@example.com")
        self.isAuthenticated = true
    }
} 