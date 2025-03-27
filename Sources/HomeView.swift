import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var selectedSubject: String?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Welcome back!")
                            .font(.title)
                            .bold()
                        
                        if let learningStyle = viewModel.selectedLearningStyle {
                            Text("Learning Style: \(learningStyle.name)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    // Active Subjects
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Active Subjects")
                            .font(.title3)
                            .bold()
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                SubjectCard(title: "Mathematics", progress: 0.7, color: .blue)
                                SubjectCard(title: "Science", progress: 0.5, color: .green)
                                SubjectCard(title: "English", progress: 0.3, color: .orange)
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Quick Actions
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Quick Actions")
                            .font(.title3)
                            .bold()
                            .padding(.horizontal)
                        
                        HStack(spacing: 15) {
                            QuickActionButton(title: "Start Learning", icon: "play.circle.fill", color: .blue)
                            QuickActionButton(title: "View Progress", icon: "chart.bar.fill", color: .green)
                            QuickActionButton(title: "Resources", icon: "book.fill", color: .orange)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Home")
        }
    }
}

struct SubjectCard: View {
    let title: String
    let progress: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(Color.secondary.opacity(0.2))
                        .frame(height: 8)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .foregroundColor(color)
                        .frame(width: geometry.size.width * progress, height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
            
            Text("\(Int(progress * 100))% Complete")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 150)
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

#Preview {
    HomeView()
} 