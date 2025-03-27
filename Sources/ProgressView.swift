import SwiftUI

struct ProgressView: View {
    var body: some View {
        Text("Progress View")
    }
}

struct LearningProgressView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Overall Progress
                VStack(alignment: .leading, spacing: 15) {
                    Text("Overall Progress")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    
                    HStack(spacing: 20) {
                        ProgressCard(
                            title: "Study Time",
                            value: "24h",
                            target: "30h",
                            icon: "clock.fill",
                            color: .blue
                        )
                        
                        ProgressCard(
                            title: "Courses",
                            value: "3",
                            target: "5",
                            icon: "book.fill",
                            color: .green
                        )
                        
                        ProgressCard(
                            title: "Achievements",
                            value: "8",
                            target: "12",
                            icon: "trophy.fill",
                            color: .orange
                        )
                    }
                    .padding(.horizontal)
                }
                
                // Learning Analytics
                VStack(alignment: .leading, spacing: 15) {
                    Text("Learning Analytics")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    
                    VStack(spacing: 15) {
                        AnalyticsRow(
                            title: "Study Time",
                            value: "24 hours",
                            trend: "+5h",
                            trendUp: true,
                            icon: "clock.fill",
                            color: .blue
                        )
                        
                        AnalyticsRow(
                            title: "Course Completion",
                            value: "60%",
                            trend: "+10%",
                            trendUp: true,
                            icon: "checkmark.circle.fill",
                            color: .green
                        )
                        
                        AnalyticsRow(
                            title: "Quiz Scores",
                            value: "85%",
                            trend: "-2%",
                            trendUp: false,
                            icon: "chart.bar.fill",
                            color: .orange
                        )
                    }
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(15)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }
                
                // Achievements
                VStack(alignment: .leading, spacing: 15) {
                    Text("Achievements")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            AchievementCard(
                                title: "Study Streak",
                                description: "7 days in a row",
                                icon: "flame.fill",
                                color: .orange
                            )
                            
                            AchievementCard(
                                title: "Course Master",
                                description: "Completed 3 courses",
                                icon: "star.fill",
                                color: .yellow
                            )
                            
                            AchievementCard(
                                title: "Social Butterfly",
                                description: "Joined 5 study groups",
                                icon: "person.3.fill",
                                color: .blue
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Learning History
                VStack(alignment: .leading, spacing: 15) {
                    Text("Learning History")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    
                    VStack(spacing: 10) {
                        HistoryRow(
                            title: "Mathematics",
                            time: "2 hours",
                            date: "Today",
                            icon: "function",
                            color: .blue
                        )
                        
                        HistoryRow(
                            title: "Science",
                            time: "1.5 hours",
                            date: "Yesterday",
                            icon: "atom",
                            color: .green
                        )
                        
                        HistoryRow(
                            title: "History",
                            time: "1 hour",
                            date: "2 days ago",
                            icon: "book.fill",
                            color: .orange
                        )
                    }
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(15)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .background(Color(uiColor: .systemBackground))
        .navigationTitle("GrowEasy Analytics")
    }
}

struct ProgressCard: View {
    let title: String
    let value: String
    let target: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.title2)
                .bold()
            
            Text("Target: \(target)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

struct AnalyticsRow: View {
    let title: String
    let value: String
    let trend: String
    let trendUp: Bool
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                Text(value)
                    .font(.headline)
            }
            
            Spacer()
            
            HStack {
                Image(systemName: trendUp ? "arrow.up.right" : "arrow.down.right")
                Text(trend)
            }
            .foregroundColor(trendUp ? .green : .red)
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(10)
    }
}

struct AchievementCard: View {
    let title: String
    let description: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            
            Text(title)
                .font(.headline)
            
            Text(description)
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

struct HistoryRow: View {
    let title: String
    let time: String
    let date: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(date)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    NavigationView {
        LearningProgressView()
    }
} 