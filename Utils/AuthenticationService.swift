import Foundation
import SwiftUI
import SwiftData

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
        #if DEBUG
        // Mock user for testing
        self.user = User(uid: "test-uid", email: "test@example.com")
        self.isAuthenticated = true
        #endif
    }
    
    func signIn(email: String, password: String) {
        self.user = User(uid: "test-uid", email: email)
        self.isAuthenticated = true
    }
    
    func signOut() {
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
} 