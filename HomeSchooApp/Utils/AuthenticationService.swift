import Foundation
import SwiftUI

public class AuthenticationService: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    
    // User class to store authenticated user info
    public class User {
        let uid: String
        let email: String?
        let displayName: String?
        let photoURL: URL?
        
        public init(uid: String, email: String?, displayName: String? = nil, photoURL: URL? = nil) {
            self.uid = uid
            self.email = email
            self.displayName = displayName
            self.photoURL = photoURL
        }
    }
    
    public init() {
        // For development: Create a mock user
        self.user = User(uid: "test-uid", email: "test@example.com")
        self.isAuthenticated = true
    }
    
    // MARK: - Authentication Methods
    
    /// Sign in with email and password
    public func signIn(email: String, password: String, completion: @escaping (Error?) -> Void = {_ in}) {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            self.user = User(uid: "test-uid", email: email)
            self.isAuthenticated = true
            self.isLoading = false
            completion(nil)
        }
    }
    
    /// Create a new account with email and password
    public func signUp(email: String, password: String, completion: @escaping (Error?) -> Void = {_ in}) {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            
            self.user = User(uid: "new-user", email: email)
            self.isAuthenticated = true
            self.isLoading = false
            completion(nil)
        }
    }
    
    /// Send password reset email
    public func resetPassword(email: String, completion: @escaping (Error?) -> Void = {_ in}) {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            self.isLoading = false
            completion(nil)
        }
    }
    
    /// Sign user out
    public func signOut() {
        self.user = nil
        self.isAuthenticated = false
    }
    
    /// Demo mode login for testing
    public func demoLogin() {
        self.user = User(uid: "demo-user-id", email: "demo@example.com", displayName: "Demo User")
        self.isAuthenticated = true
    }
} 