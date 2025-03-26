import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @StateObject private var authService = AuthenticationService()
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Parents Education Tracking System")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(isSignUp ? .newPassword : .password)
                }
                .padding(.horizontal)
                
                Button(action: {
                    Task {
                        do {
                            if isSignUp {
                                try await authService.signUp(email: email, password: password)
                            } else {
                                try await authService.signIn(email: email, password: password)
                            }
                        } catch {
                            errorMessage = error.localizedDescription
                            showError = true
                        }
                    }
                }) {
                    Text(isSignUp ? "Sign Up" : "Sign In")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: {
                    Task {
                        do {
                            try await authService.signInWithGoogle()
                        } catch {
                            errorMessage = error.localizedDescription
                            showError = true
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "g.circle.fill")
                        Text("Sign in with Google")
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: {
                    isSignUp.toggle()
                }) {
                    Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                        .foregroundColor(.blue)
                }
                
                // Developer bypass button
                Button(action: {
                    authService.isAuthenticated = true
                }) {
                    Text("Developer Bypass")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .alert("Error", isPresented: $showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthenticationService())
} 