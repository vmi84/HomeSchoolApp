import Foundation
import SwiftUI
import FirebaseAuth
import GoogleSignIn

@MainActor
final class AuthenticationService: ObservableObject {
    @Published var user: AppUser?
    @Published var isAuthenticated = false
    @Published var error: Error?
    
    // Custom User type for our app
    final class AppUser {
        let uid: String
        let email: String?
        let displayName: String?
        
        init(uid: String, email: String?, displayName: String? = nil) {
            self.uid = uid
            self.email = email
            self.displayName = displayName
        }
        
        init(from firebaseUser: User) {
            self.uid = firebaseUser.uid
            self.email = firebaseUser.email
            self.displayName = firebaseUser.displayName
        }
    }
    
    init() {
        // Listen for auth state changes
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if let user = user {
                self?.user = AppUser(from: user)
            } else {
                self?.user = nil
            }
            self?.isAuthenticated = user != nil
        }
    }
    
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.user = AppUser(from: result.user)
            self.isAuthenticated = true
        } catch {
            self.error = error
            throw error
        }
    }
    
    func signUp(email: String, password: String, name: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let changeRequest = result.user.createProfileChangeRequest()
            changeRequest.displayName = name
            try await changeRequest.commitChanges()
            self.user = AppUser(from: result.user)
            self.isAuthenticated = true
        } catch {
            self.error = error
            throw error
        }
    }
    
    func signInWithGoogle() async throws {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            throw NSError(domain: "AuthenticationService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No root view controller found"])
        }
        
        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            guard let idToken = result.user.idToken?.tokenString else {
                throw NSError(domain: "AuthenticationService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No ID token found"])
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: result.user.accessToken.tokenString
            )
            
            let authResult = try await Auth.auth().signIn(with: credential)
            self.user = AppUser(from: authResult.user)
            self.isAuthenticated = true
        } catch {
            self.error = error
            throw error
        }
    }
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isAuthenticated = false
        } catch {
            self.error = error
            throw error
        }
    }
    
    func developerBypass() {
        self.user = AppUser(uid: "dev-uid", email: "dev@example.com", displayName: "Developer")
        self.isAuthenticated = true
    }
} 