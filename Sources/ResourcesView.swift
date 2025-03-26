import SwiftUI
import UIKit

struct ResourcesView: View {
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Search Bar
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                
                // Featured Resources
                VStack(alignment: .leading, spacing: 15) {
                    Text("Featured Resources")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ResourceCard(
                                title: "Khan Academy",
                                description: "Free online courses",
                                icon: "play.circle.fill",
                                color: .blue
                            )
                            
                            ResourceCard(
                                title: "Wyzant",
                                description: "Find a tutor",
                                icon: "person.2.fill",
                                color: .green
                            )
                            
                            ResourceCard(
                                title: "Study Materials",
                                description: "Course materials",
                                icon: "doc.fill",
                                color: .orange
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Saved Courses
                VStack(alignment: .leading, spacing: 15) {
                    Text("Saved Courses")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            CourseCard(
                                title: "Mathematics",
                                progress: 0.7,
                                color: .blue
                            )
                            
                            CourseCard(
                                title: "Science",
                                progress: 0.3,
                                color: .green
                            )
                            
                            CourseCard(
                                title: "History",
                                progress: 0.5,
                                color: .orange
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Recent Activity
                VStack(alignment: .leading, spacing: 15) {
                    Text("Recent Activity")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    
                    VStack(spacing: 10) {
                        ActivityRow(
                            title: "Completed Math Quiz",
                            time: "2 hours ago",
                            icon: "checkmark.circle.fill",
                            color: .green
                        )
                        
                        ActivityRow(
                            title: "Started Science Course",
                            time: "5 hours ago",
                            icon: "play.circle.fill",
                            color: .blue
                        )
                        
                        ActivityRow(
                            title: "Booked Tutoring Session",
                            time: "1 day ago",
                            icon: "calendar",
                            color: .orange
                        )
                    }
                    .padding()
                    .background(Color(uiColor: .systemBackground))
                    .cornerRadius(15)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Resource Nexus")
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search resources...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct ResourceCard: View {
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
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

struct CourseCard: View {
    let title: String
    let progress: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            
            ProgressView(value: progress)
                .tint(color)
            
            Text("\(Int(progress * 100))% Complete")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 150)
        .padding()
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

struct ActivityRow: View {
    let title: String
    let time: String
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
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    NavigationView {
        ResourcesView()
    }
} 