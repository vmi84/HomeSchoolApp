import SwiftUI
import SwiftData

// Temporary solution until proper module imports work
public class AuthenticationService: ObservableObject {
    @Published var user: AuthUser?
    @Published var isAuthenticated = false
    
    public class AuthUser {
        let uid: String
        let email: String?
        
        init(uid: String, email: String?) {
            self.uid = uid
            self.email = email
        }
    }
    
    public func signOut() {
        user = nil
        isAuthenticated = false
    }
}

struct ContentView: View {
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        #if os(iOS) || os(visionOS)
        TabView {
            ProfileView()
                .tabItem {
                    Label("Learning Compass", systemImage: "person.fill")
                }
            
            ResourcesView()
                .tabItem {
                    Label("Resource Nexus", systemImage: "books.vertical.fill")
                }
            
            ConnectionsView()
                .tabItem {
                    Label("HomeLink", systemImage: "person.3.fill")
                }
            
            ProgressAnalyticsView()
                .tabItem {
                    Label("GrowEasy", systemImage: "chart.bar.fill")
                }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    authService.signOut()
                }) {
                    Text("Sign Out")
                }
            }
        }
        #else
        NavigationSplitView {
            List {
                NavigationLink {
                    ProfileView()
                } label: {
                    Label("Learning Compass", systemImage: "person.fill")
                }
                
                NavigationLink {
                    ResourcesView()
                } label: {
                    Label("Resource Nexus", systemImage: "books.vertical.fill")
                }
                
                NavigationLink {
                    ConnectionsView()
                } label: {
                    Label("HomeLink", systemImage: "person.3.fill")
                }
                
                NavigationLink {
                    ProgressAnalyticsView()
                } label: {
                    Label("GrowEasy", systemImage: "chart.bar.fill")
                }
                
                Button(action: {
                    authService.signOut()
                }) {
                    Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.red)
                }
                .padding(.top)
            }
            .navigationTitle("HomeSchooApp")
        } detail: {
            ProfileView()
        }
        #endif
    }
}

// Create a new ProgressAnalyticsView to replace the existing StudentProgressView
struct ProgressAnalyticsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header section
                    VStack(alignment: .leading, spacing: 8) {
                        Label("GrowEasy Analytics", systemImage: "chart.xyaxis.line")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Track and visualize your learning progress")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    // Progress overview
                    VStack(alignment: .leading, spacing: 16) {
                        Label("Progress Overview", systemImage: "chart.bar.fill")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 12) {
                            ProgressStatCard(
                                title: "Weekly Goals",
                                value: "8/10",
                                icon: "target",
                                color: .green,
                                progress: 0.8
                            )
                            
                            ProgressStatCard(
                                title: "Study Time",
                                value: "18.5h",
                                icon: "clock",
                                color: .blue,
                                progress: 0.75
                            )
                            
                            ProgressStatCard(
                                title: "Assignments",
                                value: "12/15",
                                icon: "doc.text.fill",
                                color: .purple,
                                progress: 0.8
                            )
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 8)
                    )
                    .padding(.horizontal)
                    
                    // Subject progress
                    VStack(alignment: .leading, spacing: 16) {
                        Label("Subject Progress", systemImage: "book.fill")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        SubjectProgressBar(subject: "Mathematics", progress: 0.75, color: .blue)
                        SubjectProgressBar(subject: "Science", progress: 0.6, color: .green)
                        SubjectProgressBar(subject: "Language Arts", progress: 0.85, color: .purple)
                        SubjectProgressBar(subject: "History", progress: 0.45, color: .orange)
                        SubjectProgressBar(subject: "Art", progress: 0.9, color: .pink)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 8)
                    )
                    .padding(.horizontal)
                    
                    // Recent achievements
                    VStack(alignment: .leading, spacing: 16) {
                        Label("Recent Achievements", systemImage: "rosette")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                AchievementCard(
                                    title: "Math Master",
                                    description: "Completed algebra module with 95% score",
                                    icon: "function",
                                    color: .blue,
                                    date: "2 days ago"
                                )
                                
                                AchievementCard(
                                    title: "Bookworm",
                                    description: "Read 5 books this month",
                                    icon: "book.fill",
                                    color: .purple,
                                    date: "1 week ago"
                                )
                                
                                AchievementCard(
                                    title: "Science Explorer",
                                    description: "Completed 10 lab experiments",
                                    icon: "flask.fill",
                                    color: .green,
                                    date: "2 weeks ago"
                                )
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 8)
                    )
                    .padding(.horizontal)
                    
                    // Learning insights
                    VStack(alignment: .leading, spacing: 16) {
                        Label("Learning Insights", systemImage: "lightbulb.fill")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        ForEach([
                            "Spending more time on history might improve overall balance",
                            "Math performance is consistently strong",
                            "Reading comprehension has improved by 15% this month"
                        ], id: \.self) { insight in
                            HStack(alignment: .top, spacing: 16) {
                                Image(systemName: "lightbulb.fill")
                                    .foregroundColor(.yellow)
                                    .font(.title3)
                                    .frame(width: 24)
                                
                                Text(insight)
                                    .font(.subheadline)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.yellow.opacity(0.1))
                            )
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 8)
                    )
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("GrowEasy Analytics")
        }
    }
}

struct ProgressStatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    let progress: Double
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            ProgressView(value: progress)
                .tint(color)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(color.opacity(0.1))
        )
    }
}

struct SubjectProgressBar: View {
    let subject: String
    let progress: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(subject)
                    .font(.headline)
                
                Spacer()
                
                Text("\(Int(progress * 100))%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            ProgressView(value: progress)
                .tint(color)
                .scaleEffect(x: 1, y: 1.5, anchor: .center)
        }
    }
}

struct AchievementCard: View {
    let title: String
    let description: String
    let icon: String
    let color: Color
    let date: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(color)
                    .clipShape(Circle())
                
                Spacer()
                
                Text(date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(title)
                .font(.headline)
            
            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .padding()
        .frame(width: 220, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: color.opacity(0.2), radius: 5)
        )
    }
}

#Preview {
    ContentView()
        .modelContainer(for: UserSubject.self, inMemory: true)
        .environmentObject(AuthenticationService())
} 