import Foundation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

@preconcurrency import FirebaseAuth

@MainActor
class AuthenticationService: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var error: Error?
    
    init() {
        // Initialize Firebase Auth state listener
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.isAuthenticated = user != nil
                self?.currentUser = user
            }
        }
    }
    
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            isAuthenticated = true
            currentUser = result.user
        } catch {
            self.error = error
            throw error
        }
    }
    
    func signUp(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            isAuthenticated = true
            currentUser = result.user
            
            // Update user profile with email
            let changeRequest = result.user.createProfileChangeRequest()
            changeRequest.displayName = email.components(separatedBy: "@").first
            try await changeRequest.commitChanges()
        } catch {
            self.error = error
            throw error
        }
    }
    
    func signInWithGoogle() async throws {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            throw AuthError.presentationError
        }
        
        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            guard let idToken = result.user.idToken?.tokenString else {
                throw AuthError.invalidToken
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: result.user.accessToken.tokenString
            )
            
            let authResult = try await Auth.auth().signIn(with: credential)
            isAuthenticated = true
            currentUser = authResult.user
            
            // Update user profile with Google account info
            let changeRequest = authResult.user.createProfileChangeRequest()
            changeRequest.displayName = result.user.profile?.name
            changeRequest.photoURL = result.user.profile?.imageURL(withDimension: 100)
            try await changeRequest.commitChanges()
        } catch {
            self.error = error
            throw error
        }
    }
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            isAuthenticated = false
            currentUser = nil
        } catch {
            self.error = error
            throw error
        }
    }
    
    func resetPassword(email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            self.error = error
            throw error
        }
    }
}

enum AuthError: LocalizedError {
    case presentationError
    case invalidToken
    
    var errorDescription: String? {
        switch self {
        case .presentationError:
            return "Failed to present Google Sign-in"
        case .invalidToken:
            return "Invalid authentication token"
        }
    }
} 