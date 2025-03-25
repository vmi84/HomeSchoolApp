import SwiftUI

struct ConnectionsView: View {
    @State private var searchText = ""
    
    // Sample data
    private let communities = [
        Community(name: "Math Enthusiasts", members: 345, category: "Mathematics"),
        Community(name: "Science Explorers", members: 572, category: "Science"),
        Community(name: "Literature Club", members: 218, category: "Language Arts"),
        Community(name: "History Buffs", members: 163, category: "History")
    ]
    
    private let localEvents = [
        LocalEvent(title: "Science Fair Workshop", date: "Mar 25", location: "Community Center", distance: 2.4),
        LocalEvent(title: "Book Club Meeting", date: "Mar 27", location: "Public Library", distance: 1.2),
        LocalEvent(title: "Math Competition", date: "Apr 2", location: "Memorial High School", distance: 3.8)
    ]
    
    private let tutors = [
        Tutor(name: "Sarah Johnson", subject: "Mathematics", rating: 4.9, hourlyRate: 25),
        Tutor(name: "David Chen", subject: "Physics", rating: 4.7, hourlyRate: 30),
        Tutor(name: "Maria Garcia", subject: "Spanish", rating: 4.8, hourlyRate: 22)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    // Communities section
                    VStack(alignment: .leading) {
                        Text("Learning Communities")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(communities) { community in
                                    CommunityCard(community: community)
                                        .frame(width: 240, height: 130)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Local events section
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Nearby Educational Events")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {
                                // Open maps view
                            }) {
                                Label("Map", systemImage: "map")
                                    .font(.callout)
                            }
                            .buttonStyle(.bordered)
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            ForEach(localEvents) { event in
                                EventCard(event: event)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Tutors section
                    VStack(alignment: .leading) {
                        Text("Available Tutors")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            ForEach(tutors) { tutor in
                                TutorCard(tutor: tutor)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Social connections
                    VStack(alignment: .leading) {
                        Text("Social Insights")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        SocialInsightsCard()
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("HomeLink")
            .searchable(text: $searchText, prompt: "Search connections")
        }
    }
}

struct Community: Identifiable {
    let id = UUID()
    let name: String
    let members: Int
    let category: String
}

struct LocalEvent: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let location: String
    let distance: Double
}

struct Tutor: Identifiable {
    let id = UUID()
    let name: String
    let subject: String
    let rating: Double
    let hourlyRate: Int
}

struct CommunityCard: View {
    let community: Community
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(community.name)
                .font(.headline)
            
            Text(community.category)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            HStack {
                Label("\(community.members) members", systemImage: "person.3")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Button("Join") {
                    // Join action
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.small)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
    }
}

struct EventCard: View {
    let event: LocalEvent
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.headline)
                
                Text(event.location)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Label("\(event.distance, specifier: "%.1f") miles away", systemImage: "location")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(event.date)
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                    .padding(6)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                
                Button("RSVP") {
                    // RSVP action
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
    }
}

struct TutorCard: View {
    let tutor: Tutor
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 50))
                .foregroundStyle(.blue)
            
            VStack(alignment: .leading) {
                Text(tutor.name)
                    .font(.headline)
                
                Text(tutor.subject)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    
                    Text("\(tutor.rating, specifier: "%.1f")")
                        .font(.caption)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("$\(tutor.hourlyRate)/hr")
                    .font(.headline)
                    .foregroundStyle(.blue)
                
                Button("Book") {
                    // Booking action
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
    }
}

struct SocialInsightsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "person.2.wave.2")
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
                
                VStack(alignment: .leading) {
                    Text("X API Integration")
                        .font(.headline)
                    
                    Text("Connect with learning communities")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            
            Divider()
            
            Text("Popular trending educational hashtags:")
                .font(.callout)
            
            HStack {
                ForEach(["#HomeschoolTips", "#STEM", "#EducationForAll", "#LearningJourney"], id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(6)
                        .background(Color.blue.opacity(0.1))
                        .foregroundStyle(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
            Button("Connect Account") {
                // Connect action
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
    }
}

#Preview {
    ConnectionsView()
} 