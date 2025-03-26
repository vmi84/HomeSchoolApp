import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            NavigationStack {
                ResourcesView()
            }
            .tabItem {
                Label("Resources", systemImage: "book.fill")
            }
            
            NavigationStack {
                ConnectionsView()
            }
            .tabItem {
                Label("Connections", systemImage: "person.2.fill")
            }
            
            NavigationStack {
                LearningProgressView()
            }
            .tabItem {
                Label("Progress", systemImage: "chart.bar.fill")
            }
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
        .accentColor(.blue)
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
        .environmentObject(AuthenticationService())
} 