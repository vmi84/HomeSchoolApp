import Foundation
import SwiftUI
import SwiftData

// This file contains types that need to be shared across the app
// to resolve errors related to missing types

// Authentication Service for the entire app
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
    public func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        self.user = User(uid: "test-uid", email: email)
        self.isAuthenticated = true
        completion(nil)
    }
    
    /// Create a new account with email and password
    public func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        self.user = User(uid: "new-user", email: email)
        self.isAuthenticated = true
        completion(nil)
    }
    
    /// Send password reset email
    public func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        completion(nil)
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

// UserSubject model
@Model
public final class UserSubject: Identifiable {
    public var id: UUID
    public var name: String
    public var icon: String
    public var color: String
    public var progress: Double
    public var isCustom: Bool
    
    public init(name: String, icon: String, color: String, progress: Double = 0.0, isCustom: Bool = false) {
        self.id = UUID()
        self.name = name
        self.icon = icon
        self.color = color
        self.progress = progress
        self.isCustom = isCustom
    }
} 