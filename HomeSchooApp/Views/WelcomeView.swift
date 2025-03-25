import SwiftUI
import FirebaseAuth

struct WelcomeView: View {
    @EnvironmentObject var authService: AuthenticationService
    @State private var isLogin = true
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            // Background color gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.5)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Content
            VStack(spacing: 25) {
                // Logo and title
                VStack(spacing: 15) {
                    Image(systemName: "house.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                    
                    Text("HomeSchooApp")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Your personalized homeschooling companion")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top, 50)
                
                // Form
                VStack(spacing: 20) {
                    // Toggle between login and signup
                    Picker("", selection: $isLogin) {
                        Text("Login").tag(true)
                        Text("Sign Up").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 30)
                    
                    VStack(spacing: 15) {
                        // Email field
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.gray)
                                .frame(width: 30)
                            
                            TextField("Email", text: $email)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .disableAutocorrection(true)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        
                        // Password field
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.gray)
                                .frame(width: 30)
                            
                            SecureField("Password", text: $password)
                                .disableAutocorrection(true)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        
                        // Confirm password field (for signup)
                        if !isLogin {
                            HStack {
                                Image(systemName: "lock.shield.fill")
                                    .foregroundColor(.gray)
                                    .frame(width: 30)
                                
                                SecureField("Confirm Password", text: $confirmPassword)
                                    .disableAutocorrection(true)
                            }
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    // Error message
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.callout)
                    }
                    
                    // Login/Signup button
                    Button(action: {
                        handleAuthentication()
                    }) {
                        HStack {
                            if authService.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .padding(.trailing, 10)
                            }
                            
                            Text(isLogin ? "Login" : "Sign Up")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 30)
                    .disabled(authService.isLoading || !isValidForm())
                    .opacity(isValidForm() ? 1.0 : 0.6)
                    
                    if isLogin {
                        Button(action: {
                            // Password reset action
                            if !email.isEmpty {
                                resetPassword()
                            } else {
                                errorMessage = "Please enter your email"
                            }
                        }) {
                            Text("Forgot Password?")
                                .foregroundColor(.white)
                                .underline()
                        }
                    }
                }
                
                Spacer()
                
                // Demo login for testing
                VStack {
                    Button(action: {
                        authService.demoLogin()
                    }) {
                        Text("Continue as Demo User")
                            .foregroundColor(.white)
                            .underline()
                    }
                    .padding(.bottom)
                }
            }
            .padding()
        }
    }
    
    private func isValidForm() -> Bool {
        if email.isEmpty || password.isEmpty {
            return false
        }
        
        if !isLogin && password != confirmPassword {
            return false
        }
        
        return true
    }
    
    private func handleAuthentication() {
        errorMessage = ""
        
        if isLogin {
            authService.signIn(email: email, password: password) { error in
                if let error = error {
                    errorMessage = error.localizedDescription
                }
            }
        } else {
            if password != confirmPassword {
                errorMessage = "Passwords do not match"
                return
            }
            
            authService.signUp(email: email, password: password) { error in
                if let error = error {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func resetPassword() {
        authService.resetPassword(email: email) { error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                errorMessage = "Password reset email sent!"
            }
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(AuthenticationService())
} 