import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        #if os(iOS) || os(visionOS)
        TabView {
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
            ResourcesView()
                .tabItem {
                    Label("Resources", systemImage: "folder")
                }
            
            ConnectionsView()
                .tabItem {
                    Label("Connections", systemImage: "person.2")
                }
            
            StudentProgressView()
                .tabItem {
                    Label("Progress", systemImage: "chart.bar")
                }
        }
        #else
        NavigationSplitView {
            List {
                NavigationLink {
                    ProfileView()
                } label: {
                    Label("Profile", systemImage: "person")
                }
                
                NavigationLink {
                    ResourcesView()
                } label: {
                    Label("Resources", systemImage: "folder")
                }
                
                NavigationLink {
                    ConnectionsView()
                } label: {
                    Label("Connections", systemImage: "person.2")
                }
                
                NavigationLink {
                    StudentProgressView()
                } label: {
                    Label("Progress", systemImage: "chart.bar")
                }
            }
            .navigationTitle("HomeSchooApp")
        } detail: {
            ProfileView()
        }
        #endif
    }
}

#Preview {
    ContentView()
        .modelContainer(for: UserSubject.self, inMemory: true)
        .environmentObject(AuthenticationService())
} 