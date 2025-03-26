import SwiftUI
import UIKit

struct HomeView: View {
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Header
                VStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)
                    
                    Text(authService.currentUser?.email ?? "Student Name")
                        .font(.title2)
                        .bold()
                    
                    Text("Grade Level")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(uiColor: .systemBackground))
                .cornerRadius(15)
                .shadow(radius: 2)
                
                // Learning Compass
                VStack(alignment: .leading, spacing: 15) {
                    Text("Learning Compass")
                        .font(.title3)
                        .bold()
                    
                    // Learning Style Card
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Learning Style", systemImage: "brain.head.profile")
                            .font(.headline)
                        Text("Visual Learner")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(10)
                    
                    // Goals Card
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Current Goals", systemImage: "target")
                            .font(.headline)
                        Text("Complete Math Course")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(10)
                }
                .padding()
                .background(Color(uiColor: .systemBackground))
                .cornerRadius(15)
                .shadow(radius: 2)
                
                // Quick Actions
                VStack(alignment: .leading, spacing: 15) {
                    Text("Quick Actions")
                        .font(.title3)
                        .bold()
                    
                    HStack(spacing: 20) {
                        QuickActionButton(title: "Start Learning", icon: "play.fill", color: .blue)
                        QuickActionButton(title: "Find Tutor", icon: "person.2.fill", color: .green)
                        QuickActionButton(title: "Study Group", icon: "person.3.fill", color: .orange)
                    }
                }
                .padding()
                .background(Color(uiColor: .systemBackground))
                .cornerRadius(15)
                .shadow(radius: 2)
            }
            .padding()
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Learning Compass")
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            Text(title)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    NavigationView {
        HomeView()
            .environmentObject(AuthenticationService())
    }
} 