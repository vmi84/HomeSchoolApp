import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        NavigationView {
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
                        Label("Connections", systemImage: "person.3.fill")
                    }
                
                LearningProgressView()
                    .tabItem {
                        Label("Progress", systemImage: "chart.bar.fill")
                    }
            }
            .accentColor(.blue)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationService())
} 