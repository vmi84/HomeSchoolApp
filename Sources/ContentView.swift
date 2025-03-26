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
                Label("Connections", systemImage: "person.3.fill")
            }
            
            NavigationStack {
                LearningProgressView()
            }
            .tabItem {
                Label("Progress", systemImage: "chart.bar.fill")
            }
        }
        .accentColor(.blue)
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationService())
} 