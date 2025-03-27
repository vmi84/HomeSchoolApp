import SwiftUI

struct ContentView: View {
    @StateObject private var authService = AuthenticationService()
    
    var body: some View {
        Group {
            if !authService.isAuthenticated {
                LoginView()
                    .environmentObject(authService)
            } else {
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
                .accentColor(.blue)
            }
        }
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