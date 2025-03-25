import SwiftUI
import MapKit

struct ConnectionsView: View {
    @State private var searchText = ""
    @State private var selectedFilter = "All"
    @State private var showingMapView = false
    @State private var showingSocialPostModal = false
    @State private var showingCommunityDetail: Community?
    
    // Filters
    private let filterOptions = ["All", "Communities", "Events", "Tutors"]
    
    // Sample data
    private let communities = [
        Community(name: "Math Enthusiasts", members: 345, category: "Mathematics", description: "A community of parents and students passionate about exploring mathematics beyond the typical curriculum."),
        Community(name: "Science Explorers", members: 572, category: "Science", description: "Hands-on science experiments, field trips, and collaborative projects for curious minds."),
        Community(name: "Literature Club", members: 218, category: "Language Arts", description: "Reading, writing, and discussing literature from classic to contemporary works."),
        Community(name: "History Buffs", members: 163, category: "History", description: "Exploring world history through engaging discussions, reenactments, and museum visits.")
    ]
    
    private let localEvents = [
        LocalEvent(title: "Science Fair Workshop", date: "Mar 25, 2024", time: "3:00 PM - 5:00 PM", location: "Community Center", distance: 2.4, attendees: 18, isRegistered: false),
        LocalEvent(title: "Book Club Meeting", date: "Mar 27, 2024", time: "4:30 PM - 6:00 PM", location: "Public Library", distance: 1.2, attendees: 12, isRegistered: true),
        LocalEvent(title: "Math Competition", date: "Apr 2, 2024", time: "9:00 AM - 12:00 PM", location: "Memorial High School", distance: 3.8, attendees: 45, isRegistered: false),
        LocalEvent(title: "Homeschool Co-op Meetup", date: "Apr 5, 2024", time: "1:00 PM - 3:00 PM", location: "Riverside Park", distance: 0.8, attendees: 28, isRegistered: true)
    ]
    
    private let tutors = [
        Tutor(name: "Sarah Johnson", subject: "Mathematics", specialties: ["Algebra", "Calculus"], experience: "10 years", rating: 4.9, hourlyRate: 25, isFavorite: true),
        Tutor(name: "David Chen", subject: "Physics", specialties: ["Mechanics", "Electricity"], experience: "8 years", rating: 4.7, hourlyRate: 30, isFavorite: false),
        Tutor(name: "Maria Garcia", subject: "Spanish", specialties: ["Conversation", "Grammar"], experience: "12 years", rating: 4.8, hourlyRate: 22, isFavorite: true),
        Tutor(name: "Robert Wilson", subject: "Computer Science", specialties: ["Python", "Web Development"], experience: "5 years", rating: 4.6, hourlyRate: 35, isFavorite: false)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Filter options
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(filterOptions, id: \.self) { filter in
                            Button(action: {
                                selectedFilter = filter
                            }) {
                                Text(filter)
                                    .font(.subheadline)
                                    .fontWeight(selectedFilter == filter ? .bold : .regular)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        Capsule()
                                            .fill(selectedFilter == filter ? Color.blue : Color.blue.opacity(0.1))
                                    )
                                    .foregroundColor(selectedFilter == filter ? .white : .blue)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                .background(Color(.systemBackground))
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Communities section
                        if selectedFilter == "All" || selectedFilter == "Communities" {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Label("Learning Communities", systemImage: "person.3.fill")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        // Create community action
                                    }) {
                                        Label("Create", systemImage: "plus.circle.fill")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding(.horizontal)
                                
                                Text("Connect with other homeschooling families")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(communities) { community in
                                            Button {
                                                showingCommunityDetail = community
                                            } label: {
                                                CommunityCard(community: community)
                                                    .frame(width: 260, height: 150)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        
                        // Local events section
                        if selectedFilter == "All" || selectedFilter == "Events" {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Label("Nearby Educational Events", systemImage: "calendar")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        showingMapView = true
                                    }) {
                                        Label("Map", systemImage: "map.fill")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                            .padding(.vertical, 6)
                                            .padding(.horizontal, 12)
                                            .background(Color.blue.opacity(0.1))
                                            .clipShape(Capsule())
                                    }
                                }
                                .padding(.horizontal)
                                
                                Text("Educational opportunities in your area")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                
                                VStack(spacing: 16) {
                                    ForEach(localEvents) { event in
                                        EventCard(event: event)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Tutors section
                        if selectedFilter == "All" || selectedFilter == "Tutors" {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Label("Expert Tutors", systemImage: "person.fill.viewfinder")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        // Filter tutors action
                                    }) {
                                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle.fill")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                            .padding(.vertical, 6)
                                            .padding(.horizontal, 12)
                                            .background(Color.blue.opacity(0.1))
                                            .clipShape(Capsule())
                                    }
                                }
                                .padding(.horizontal)
                                
                                Text("Find specialists for specific subjects")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                
                                VStack(spacing: 16) {
                                    ForEach(tutors) { tutor in
                                        TutorCard(tutor: tutor)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Social connections section
                        if selectedFilter == "All" {
                            VStack(alignment: .leading, spacing: 12) {
                                Label("Homeschool Social Feed", systemImage: "bubble.left.and.bubble.right.fill")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                Text("Share and discover with fellow homeschoolers")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                
                                Button(action: {
                                    showingSocialPostModal = true
                                }) {
                                    HStack {
                                        Image(systemName: "person.crop.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(.blue)
                                        
                                        Text("Share your homeschool experience...")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color(.systemBackground))
                                            .shadow(color: Color.black.opacity(0.05), radius: 5)
                                    )
                                }
                                .padding(.horizontal)
                                .buttonStyle(PlainButtonStyle())
                                
                                ForEach(1...3, id: \.self) { index in
                                    SocialPostCard(
                                        username: "HomeschoolParent\(index)",
                                        timeAgo: "\(index * 2) hours ago",
                                        content: socialPosts[index - 1],
                                        likes: index * 18 + 5,
                                        comments: index * 4 + 2
                                    )
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
            }
            .navigationTitle("HomeLink")
            .searchable(text: $searchText, prompt: "Search communities, events, and tutors")
            .sheet(item: $showingCommunityDetail) { community in
                CommunityDetailView(community: community)
            }
            .sheet(isPresented: $showingMapView) {
                EventMapView(events: localEvents)
            }
            .sheet(isPresented: $showingSocialPostModal) {
                SocialPostFormView()
            }
        }
    }
    
    // Sample social post content
    private let socialPosts = [
        "Just finished a fantastic geology unit with a hike at Bryce Canyon. The kids collected rock samples and learned about sedimentary formations firsthand. Love when learning becomes an adventure! #homeschooling #scienceinthewild",
        
        "Switched to a project-based approach this semester and seeing amazing results! My 11-year-old just finished building a working model windmill while learning about renewable energy. So proud of her initiative and problem-solving skills.",
        
        "Looking for recommendations on middle school literature that incorporates history? We're studying ancient civilizations and I'd love to supplement with historical fiction. Any favorite books your kids have enjoyed? #curriculumsharing"
    ]
}

// MARK: - Supporting Models

struct Community: Identifiable {
    let id = UUID()
    let name: String
    let members: Int
    let category: String
    let description: String
}

struct LocalEvent: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let time: String
    let location: String
    let distance: Double
    let attendees: Int
    let isRegistered: Bool
}

struct Tutor: Identifiable {
    let id = UUID()
    let name: String
    let subject: String
    let specialties: [String]
    let experience: String
    let rating: Double
    let hourlyRate: Int
    let isFavorite: Bool
}

// MARK: - Supporting Views

struct CommunityCard: View {
    let community: Community
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(community.name)
                .font(.headline)
            
            HStack {
                Text(community.category)
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .clipShape(Capsule())
                
                Spacer()
            }
            
            Text(community.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            Spacer()
            
            HStack {
                Label("\(community.members) members", systemImage: "person.3.fill")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button("Join") {
                    // Join action
                }
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
    }
}

struct EventCard: View {
    let event: LocalEvent
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .center, spacing: 4) {
                Text(event.date.components(separatedBy: ",").first ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                
                Text(event.date.components(separatedBy: ",").last ?? "")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(width: 60)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(event.title)
                    .font(.headline)
                
                Label(event.time, systemImage: "clock.fill")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Label(event.location, systemImage: "mappin.circle.fill")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack {
                    Label("\(event.attendees) attending", systemImage: "person.2.fill")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Label("\(event.distance, specifier: "%.1f") mi", systemImage: "location.fill")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Button {
                // RSVP action
            } label: {
                Text(event.isRegistered ? "Registered" : "RSVP")
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(event.isRegistered ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
    }
}

struct TutorCard: View {
    let tutor: Tutor
    @State private var isFavorite: Bool
    
    init(tutor: Tutor) {
        self.tutor = tutor
        self._isFavorite = State(initialValue: tutor.isFavorite)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Image(systemName: tutor.subject == "Mathematics" ? "function" : 
                               (tutor.subject == "Physics" ? "atom" : 
                               (tutor.subject == "Spanish" ? "globe.americas.fill" : "laptopcomputer")))
                    .font(.system(size: 16))
                    .padding(4)
                    .background(Circle().fill(Color.white))
                    .foregroundColor(.blue)
                    .offset(x: 4, y: 4)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(tutor.name)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button {
                        isFavorite.toggle()
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .gray)
                    }
                }
                
                Text(tutor.subject + " • " + tutor.experience)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    ForEach(tutor.specialties, id: \.self) { specialty in
                        Text(specialty)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .clipShape(Capsule())
                    }
                }
                
                HStack {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                        
                        Text("\(tutor.rating, specifier: "%.1f")")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Text("$\(tutor.hourlyRate)/hr")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
            
            VStack {
                Button {
                    // Message action
                } label: {
                    Image(systemName: "message.fill")
                        .padding(8)
                        .background(Circle().fill(Color.blue.opacity(0.1)))
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Button {
                    // Book action
                } label: {
                    Text("Book")
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
    }
}

struct SocialPostCard: View {
    let username: String
    let timeAgo: String
    let content: String
    let likes: Int
    let comments: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .font(.title3)
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading) {
                    Text(username)
                        .font(.headline)
                    
                    Text(timeAgo)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Menu {
                    Button("Save", action: {})
                    Button("Report", action: {})
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.secondary)
                }
            }
            
            Text(content)
                .font(.subheadline)
            
            HStack(spacing: 20) {
                Button {
                    // Like action
                } label: {
                    Label("\(likes)", systemImage: "heart")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Button {
                    // Comment action
                } label: {
                    Label("\(comments)", systemImage: "bubble.left")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button {
                    // Share action
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
    }
}

struct CommunityDetailView: View {
    let community: Community
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Community header
                    VStack(alignment: .center, spacing: 12) {
                        Image(systemName: "person.3.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        Text(community.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text(community.category)
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Label("\(community.members) members", systemImage: "person.2.fill")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    
                    // Description
                    VStack(alignment: .leading, spacing: 12) {
                        Text("About This Community")
                            .font(.headline)
                        
                        Text(community.description)
                            .font(.body)
                        
                        Text("This community provides a supportive environment for homeschooling families to collaborate, share resources, and organize group activities related to \(community.category.lowercased()).")
                            .font(.body)
                    }
                    .padding(.horizontal)
                    
                    // Recent activity
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Activity")
                            .font(.headline)
                        
                        ForEach(1...3, id: \.self) { i in
                            HStack(spacing: 16) {
                                Image(systemName: ["doc.fill", "calendar", "person.2.fill"][i % 3])
                                    .font(.title3)
                                    .foregroundColor(.blue)
                                    .frame(width: 40, height: 40)
                                    .background(Circle().fill(Color.blue.opacity(0.1)))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(["New resource shared", "Upcoming event posted", "New member joined"][i % 3])
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    Text("\(i * 2) hours ago")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: Color.black.opacity(0.05), radius: 3)
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // Join button
                    Button {
                        // Join community action
                    } label: {
                        Text("Join Community")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.blue)
                            )
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                }
                .padding(.vertical)
            }
            .navigationTitle("Community Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct EventMapView: View {
    let events: [LocalEvent]
    @Environment(\.dismiss) private var dismiss
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        NavigationStack {
            Map(coordinateRegion: $region, annotationItems: events.enumerated().map { index, event in
                MapEvent(id: event.id, title: event.title, location: event.location, coordinate: generateCoordinate(for: index))
            }) { mapEvent in
                MapAnnotation(coordinate: mapEvent.coordinate) {
                    VStack {
                        Image(systemName: "calendar.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.blue)
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 2)
                        
                        Text(mapEvent.title)
                            .font(.caption)
                            .padding(4)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(4)
                            .shadow(radius: 1)
                    }
                }
            }
            .navigationTitle("Educational Events")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // Generate fake coordinates for demonstration
    private func generateCoordinate(for index: Int) -> CLLocationCoordinate2D {
        let baseLatitude = 37.7749
        let baseLongitude = -122.4194
        
        return CLLocationCoordinate2D(
            latitude: baseLatitude + Double((index % 5) - 2) * 0.01,
            longitude: baseLongitude + Double((index % 3) - 1) * 0.01
        )
    }
}

struct MapEvent: Identifiable {
    let id: UUID
    let title: String
    let location: String
    let coordinate: CLLocationCoordinate2D
}

struct SocialPostFormView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var postText = ""
    @State private var isPublic = true
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack(alignment: .top) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                    
                    TextEditor(text: $postText)
                        .frame(minHeight: 150)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                        .overlay(
                            Group {
                                if postText.isEmpty {
                                    HStack {
                                        Text("Share your homeschool experience...")
                                            .foregroundColor(.gray.opacity(0.7))
                                            .padding(.leading, 16)
                                            .padding(.top, 16)
                                        Spacer()
                                    }
                                    .allowsHitTesting(false)
                                }
                            }
                        )
                }
                
                Divider()
                
                Toggle(isOn: $isPublic) {
                    Label("Public post", systemImage: "globe")
                }
                
                HStack {
                    Button {
                        // Add photo
                    } label: {
                        Label("Photo", systemImage: "photo")
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Button {
                        // Add location
                    } label: {
                        Label("Location", systemImage: "location")
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Spacer()
                    
                    Button {
                        // Post action
                        dismiss()
                    } label: {
                        Text("Share Post")
                            .fontWeight(.medium)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                            .background(postText.isEmpty ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    .disabled(postText.isEmpty)
                }
            }
            .padding()
            .navigationTitle("Create Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ConnectionsView()
} 