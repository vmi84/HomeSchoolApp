import SwiftUI

struct ContentView: View {
    @StateObject private var authService = AuthenticationService()
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        Group {
            if authService.isAuthenticated {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    
                    ResourcesView()
                        .tabItem {
                            Label("Resources", systemImage: "book.fill")
                        }
                    
                    ConnectionsView()
                        .tabItem {
                            Label("Connections", systemImage: "person.2.fill")
                        }
                    
                    LearningProgressView()
                        .tabItem {
                            Label("Progress", systemImage: "chart.bar.fill")
                        }
                    
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
                .environmentObject(settingsViewModel)
            } else {
                LoginView()
                    .environmentObject(authService)
            }
        }
        .background(Color(uiColor: .systemBackground))
    }
}

struct LearningCompassView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Your existing Learning Compass content here
                Text("Learning Compass Content")
                    .font(.title)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
} 