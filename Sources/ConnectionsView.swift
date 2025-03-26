import SwiftUI
import MapKit
import UIKit

struct ConnectionsView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Map View
                Map(coordinateRegion: $region)
                    .frame(height: 200)
                    .cornerRadius(15)
                    .padding(.horizontal)
                
                // Study Groups
                VStack(alignment: .leading, spacing: 15) {
                    Text("Study Groups")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            GroupCard(
                                title: "Math Study Group",
                                members: 5,
                                subject: "Mathematics",
                                color: .blue
                            )
                            
                            GroupCard(
                                title: "Science Club",
                                members: 8,
                                subject: "Science",
                                color: .green
                            )
                            
                            GroupCard(
                                title: "History Discussion",
                                members: 6,
                                subject: "History",
                                color: .orange
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Social Feed
                VStack(alignment: .leading, spacing: 15) {
                    Text("Social Feed")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    
                    VStack(spacing: 10) {
                        SocialPost(
                            author: "John Doe",
                            content: "Just completed the math quiz!",
                            time: "2 hours ago",
                            likes: 5,
                            comments: 2
                        )
                        
                        SocialPost(
                            author: "Jane Smith",
                            content: "Looking for study partners for the science exam",
                            time: "4 hours ago",
                            likes: 3,
                            comments: 4
                        )
                        
                        SocialPost(
                            author: "Mike Johnson",
                            content: "Great study session today!",
                            time: "6 hours ago",
                            likes: 7,
                            comments: 1
                        )
                    }
                    .padding()
                    .background(Color(uiColor: .systemBackground))
                    .cornerRadius(15)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }
                
                // Messages
                VStack(alignment: .leading, spacing: 15) {
                    Text("Messages")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    
                    VStack(spacing: 10) {
                        MessageRow(
                            name: "Study Group Chat",
                            lastMessage: "See you tomorrow!",
                            time: "5m ago",
                            unread: 2
                        )
                        
                        MessageRow(
                            name: "Tutor",
                            lastMessage: "Great progress!",
                            time: "1h ago",
                            unread: 0
                        )
                        
                        MessageRow(
                            name: "Class Group",
                            lastMessage: "Don't forget the assignment",
                            time: "2h ago",
                            unread: 1
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
        .navigationTitle("HomeLink")
    }
}

struct GroupCard: View {
    let title: String
    let members: Int
    let subject: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            
            HStack {
                Image(systemName: "person.3.fill")
                Text("\(members) members")
                    .font(.caption)
            }
            .foregroundColor(.gray)
            
            Text(subject)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(color.opacity(0.2))
                .foregroundColor(color)
                .cornerRadius(8)
        }
        .frame(width: 150)
        .padding()
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

struct SocialPost: View {
    let author: String
    let content: String
    let time: String
    let likes: Int
    let comments: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading) {
                    Text(author)
                        .font(.subheadline)
                        .bold()
                    Text(time)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Text(content)
                .font(.subheadline)
            
            HStack {
                Button(action: {}) {
                    Label("\(likes)", systemImage: "heart")
                }
                
                Spacer()
                
                Button(action: {}) {
                    Label("\(comments)", systemImage: "bubble.right")
                }
            }
            .foregroundColor(.gray)
        }
        .padding()
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(10)
    }
}

struct MessageRow: View {
    let name: String
    let lastMessage: String
    let time: String
    let unread: Int
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.subheadline)
                    .bold()
                Text(lastMessage)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if unread > 0 {
                    Text("\(unread)")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        ConnectionsView()
    }
} 