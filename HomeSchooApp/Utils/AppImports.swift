import Foundation
import SwiftUI
import SwiftData

#if canImport(UIKit)
import UIKit
#endif

// Firebase imports
#if canImport(FirebaseCore)
import FirebaseCore
#endif

#if canImport(FirebaseAuth)
import FirebaseAuth
#endif

#if canImport(FirebaseFirestore)
import FirebaseFirestore
#endif

#if canImport(FirebaseStorage)
import FirebaseStorage
#endif

#if canImport(FirebaseDatabase)
import FirebaseDatabase
#endif

// Type aliases for cleaner code - these will be resolved at compile time when Firebase is imported
#if canImport(FirebaseAuth) && canImport(FirebaseFirestore) && canImport(FirebaseStorage)
typealias FIRAuth = Auth
typealias FIRUser = FirebaseAuth.User
typealias FIRFirestore = Firestore
typealias FIRTimestamp = Timestamp
typealias FIRReference = DocumentReference
typealias FIRStorage = Storage
typealias FIRStorageReference = StorageReference
#endif

/// App constants
enum AppConstants {
    static let appName = "HomeSchooApp"
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    static let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    
    // Collection names
    enum Collection {
        static let users = "users"
        static let subjects = "subjects"
        static let learningGoals = "learningGoals"
        static let assessments = "assessments"
        static let achievements = "achievements"
    }
    
    // Storage paths
    enum Storage {
        static let userProfiles = "userProfiles"
        static let subjects = "subjects"
    }
}

/// App theme colors
enum AppColors {
    static let primary = Color.blue
    static let secondary = Color.purple
    static let accent = Color.orange
    
    #if os(iOS) || os(visionOS)
    static let background = Color(UIColor.systemBackground)
    static let text = Color(UIColor.label)
    static let textSecondary = Color(UIColor.secondaryLabel)
    #elseif os(macOS)
    static let background = Color(NSColor.windowBackgroundColor)
    static let text = Color(NSColor.labelColor)
    static let textSecondary = Color(NSColor.secondaryLabelColor)
    #else
    static let background = Color.white
    static let text = Color.black
    static let textSecondary = Color.gray
    #endif
}

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