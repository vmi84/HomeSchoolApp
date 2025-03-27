import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authService: AuthenticationService
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var isSignUp = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Welcome Header
                VStack(spacing: 10) {
                    Text("Welcome to")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    Text("PETS")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.blue)
                    
                    Text("Parents Education Tracking System")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 50)
                
                // Login Form
                VStack(spacing: 15) {
                    if isSignUp {
                        TextField("Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .textContentType(.name)
                            .autocapitalization(.words)
                    }
                    
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
                
                // Sign In/Up Button
                Button(action: {
                    Task {
                        do {
                            if isSignUp {
                                try await authService.signUp(email: email, password: password, name: name)
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
                
                // Google Sign In
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
                
                // Toggle Sign In/Up
                Button(action: {
                    isSignUp.toggle()
                }) {
                    Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                        .foregroundColor(.blue)
                }
                
                // Developer Bypass
                VStack(spacing: 10) {
                    Divider()
                        .padding(.vertical, 10)
                    
                    Text("Development Options")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        authService.developerBypass()
                    }) {
                        Text("Developer Bypass")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
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