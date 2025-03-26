import SwiftUI
import MapKit

struct ResourcesView: View {
    @State private var searchText = ""
    @State private var selectedCategory: ResourceCategory?
    @State private var showingMapView = false
    @State private var isLoadingKhanResources = false
    @State private var isLoadingTutors = false
    
    // Sample data
    private let resourceCategories = [
        ResourceCategory(name: "Curriculum", icon: "book.fill", color: "blue", count: 25),
        ResourceCategory(name: "Videos", icon: "play.fill", color: "red", count: 42),
        ResourceCategory(name: "Worksheets", icon: "doc.fill", color: "green", count: 18),
        ResourceCategory(name: "Activities", icon: "gamecontroller.fill", color: "purple", count: 13),
        ResourceCategory(name: "Assessments", icon: "checkmark.square.fill", color: "orange", count: 7)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Featured resources carousel
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Featured Resources", systemImage: "star.fill")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(0..<4) { index in
                                    FeaturedResourceCard(
                                        title: featuredTitles[index],
                                        description: featuredDescriptions[index],
                                        image: featuredImages[index],
                                        color: index % 2 == 0 ? "blue" : "purple"
                                    )
                                    .frame(width: 280, height: 160)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Resource categories
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Browse by Category", systemImage: "folder.fill")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(resourceCategories) { category in
                                Button {
                                    selectedCategory = category
                                } label: {
                                    ResourceCategoryCard(category: category)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Khan Academy integration
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Khan Academy", systemImage: "graduationcap.fill")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        if isLoadingKhanResources {
                            ProgressView("Loading curriculum resources...")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        } else {
                            VStack(spacing: 12) {
                                KhanAcademyResourceCard(
                                    title: "Algebra Fundamentals",
                                    type: "Course",
                                    duration: "4-6 weeks",
                                    level: "Grades 7-9"
                                )
                                
                                KhanAcademyResourceCard(
                                    title: "Chemistry Basics",
                                    type: "Course",
                                    duration: "8 weeks",
                                    level: "Grades 9-11"
                                )
                                
                                KhanAcademyResourceCard(
                                    title: "U.S. History",
                                    type: "Course",
                                    duration: "10 weeks",
                                    level: "Grades 8-12"
                                )
                                
                                Button {
                                    // This would actually use the APIManager in a real implementation
                                    isLoadingKhanResources = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        isLoadingKhanResources = false
                                    }
                                } label: {
                                    Text("Load More Courses")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(Color.green)
                                        .clipShape(Capsule())
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 8)
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Wyzant Tutors integration
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Find Tutors", systemImage: "person.2.fill")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        if isLoadingTutors {
                            ProgressView("Searching for tutors...")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        } else {
                            VStack(spacing: 12) {
                                ForEach(tutorSamples) { tutor in
                                    TutorCard(tutor: tutor)
                                }
                                
                                Button {
                                    // This would actually use the APIManager in a real implementation
                                    isLoadingTutors = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        isLoadingTutors = false
                                    }
                                } label: {
                                    Text("Find More Tutors")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(Color.blue)
                                        .clipShape(Capsule())
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 8)
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Google Maps integration
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Educational Locations", systemImage: "map.fill")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        Button {
                            showingMapView = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.orange.opacity(0.1))
                                
                                VStack(spacing: 12) {
                                    Image(systemName: "map.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.orange)
                                    
                                    Text("Discover Nearby Educational Resources")
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                    
                                    Text("Libraries, Museums, Educational Centers")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                    
                                    Text("Tap to Open Map")
                                        .font(.caption)
                                        .foregroundColor(.orange)
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 16)
                                        .background(Color.orange.opacity(0.2))
                                        .clipShape(Capsule())
                                }
                                .padding()
                            }
                            .frame(height: 200)
                        }
                        .padding(.horizontal)
                        .sheet(isPresented: $showingMapView) {
                            EducationalMapView()
                        }
                    }
                    
                    // X API Social insights
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Homeschooling Insights", systemImage: "bubble.left.and.bubble.right.fill")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(socialInsightSamples) { insight in
                                    SocialInsightCard(insight: insight)
                                        .frame(width: 300)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Resource Nexus")
            .searchable(text: $searchText, prompt: "Search resources")
            .sheet(item: $selectedCategory) { category in
                ResourceCategoryDetailView(category: category)
            }
        }
    }
    
    // Sample data
    private let featuredTitles = [
        "Grade 5 Science Unit",
        "Reading Comprehension",
        "Math Problem Solving",
        "History Exploration"
    ]
    
    private let featuredDescriptions = [
        "Complete curriculum with experiments",
        "Interactive reading activities",
        "Step-by-step math tutorials",
        "Engaging historical narratives"
    ]
    
    private let featuredImages = [
        "flask.fill",
        "book.fill",
        "function",
        "scroll.fill"
    ]
    
    private let tutorSamples = [
        Tutor(name: "Jennifer K.", subject: "Mathematics", rating: 4.9, hourlyRate: 45, imageSystemName: "person.crop.circle.fill"),
        Tutor(name: "Michael T.", subject: "Science", rating: 4.7, hourlyRate: 50, imageSystemName: "person.crop.circle.fill"),
        Tutor(name: "Sarah L.", subject: "English", rating: 4.8, hourlyRate: 40, imageSystemName: "person.crop.circle.fill")
    ]
    
    private let socialInsightSamples = [
        SocialInsight(username: "@HomeschoolMom", content: "Just finished our science unit on ecosystems with a wonderful field trip to the local pond. The kids collected samples and we're analyzing them under microscopes today! #homeschooling", likes: 128, reposts: 42),
        SocialInsight(username: "@DadTeacher", content: "Finding great success with project-based learning this semester. Current project: designing and building a small solar-powered car. Engineering and physics in action! #STEM #homeschooling", likes: 95, reposts: 31),
        SocialInsight(username: "@TeenLearner", content: "Started my online college-level course today while still homeschooling high school. Love the flexibility to work at my own pace! #dualenrollment #homeschooling", likes: 156, reposts: 47)
    ]
}

// MARK: - Supporting Models

struct ResourceCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: String
    let count: Int
}

struct Tutor: Identifiable {
    let id = UUID()
    let name: String
    let subject: String
    let rating: Double
    let hourlyRate: Int
    let imageSystemName: String
}

struct SocialInsight: Identifiable {
    let id = UUID()
    let username: String
    let content: String
    let likes: Int
    let reposts: Int
}

// MARK: - Supporting Views

struct ResourceCategoryCard: View {
    let category: ResourceCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: category.icon)
                    .font(.title2)
                    .foregroundStyle(Color(category.color))
                Spacer()
                Text("\(category.count)")
                    .font(.caption)
                    .padding(5)
                    .background(Color(category.color).opacity(0.2))
                    .clipShape(Capsule())
            }
            
            Text(category.name)
                .font(.headline)
            
            Text("Browse resources")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 5)
        )
    }
}

struct FeaturedResourceCard: View {
    let title: String
    let description: String
    let image: String
    let color: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.8))
                }
                
                Spacer()
                
                Image(systemName: image)
                    .font(.largeTitle)
                    .foregroundStyle(.white.opacity(0.8))
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundStyle(.yellow)
                Text("Featured")
                    .font(.caption)
                    .foregroundStyle(.white)
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundStyle(.white)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(color))
        )
    }
}

struct KhanAcademyResourceCard: View {
    let title: String
    let type: String
    let duration: String
    let level: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "graduationcap.fill")
                .font(.title2)
                .foregroundColor(.green)
                .frame(width: 50, height: 50)
                .background(Color.green.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                
                HStack(spacing: 12) {
                    Label(type, systemImage: "book.fill")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Label(duration, systemImage: "clock.fill")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Label(level, systemImage: "chart.bar.fill")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Button {
                // Action for viewing the resource
            } label: {
                Text("View")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.green)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.green.opacity(0.1))
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 5)
        )
    }
}

struct TutorCard: View {
    let tutor: Tutor
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: tutor.imageSystemName)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .frame(width: 60, height: 60)
                .background(Color.blue.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(tutor.name)
                    .font(.headline)
                
                Text(tutor.subject + " Specialist")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                    
                    Text("\(tutor.rating, specifier: "%.1f")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("·")
                        .foregroundColor(.secondary)
                    
                    Text("$\(tutor.hourlyRate)/hour")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Button {
                // Action for contacting the tutor
            } label: {
                Text("Contact")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 5)
        )
    }
}

struct SocialInsightCard: View {
    let insight: SocialInsight
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .font(.title3)
                    .foregroundColor(.blue)
                
                Text(insight.username)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "checkmark.seal.fill")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            
            Text(insight.content)
                .font(.subheadline)
                .lineLimit(4)
            
            HStack {
                Label("\(insight.likes)", systemImage: "heart")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Label("\(insight.reposts)", systemImage: "arrow.2.squarepath")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 5)
        )
    }
}

struct ResourceCategoryDetailView: View {
    let category: ResourceCategory
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Category resources would be loaded here
                VStack(spacing: 20) {
                    ForEach(1...10, id: \.self) { index in
                        ResourceItemRow(
                            title: "\(category.name) Resource \(index)",
                            type: index % 3 == 0 ? "PDF" : (index % 3 == 1 ? "Video" : "Interactive"),
                            rating: Double(3 + (index % 3)) / 1.0,
                            color: category.color
                        )
                    }
                }
                .padding()
            }
            .navigationTitle(category.name)
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

struct ResourceItemRow: View {
    let title: String
    let type: String
    let rating: Double
    let color: String
    
    var body: some View {
        HStack {
            Image(systemName: type == "PDF" ? "doc.fill" : (type == "Video" ? "play.rectangle.fill" : "apps.iphone"))
                .font(.title2)
                .foregroundColor(Color(color))
                .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                
                HStack {
                    Text(type)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color(color).opacity(0.1))
                        .clipShape(Capsule())
                    
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= Int(rating) ? "star.fill" : "star")
                                .font(.caption)
                                .foregroundColor(star <= Int(rating) ? .yellow : .gray)
                        }
                    }
                }
            }
            
            Spacer()
            
            Button {
                // Action to view resource
            } label: {
                Image(systemName: "arrow.down.circle.fill")
                    .font(.title3)
                    .foregroundColor(Color(color))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 4)
        )
    }
}

struct EducationalMapView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    let locations = [
        MapLocation(name: "Public Library", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), type: "library"),
        MapLocation(name: "Science Museum", coordinate: CLLocationCoordinate2D(latitude: 37.7780, longitude: -122.4150), type: "museum"),
        MapLocation(name: "Community Center", coordinate: CLLocationCoordinate2D(latitude: 37.7720, longitude: -122.4220), type: "center"),
        MapLocation(name: "Educational Workshop", coordinate: CLLocationCoordinate2D(latitude: 37.7790, longitude: -122.4250), type: "workshop")
    ]
    
    var body: some View {
        NavigationStack {
            Map(coordinateRegion: $region, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(systemName: iconForType(location.type))
                            .font(.system(size: 24))
                            .foregroundColor(colorForType(location.type))
                            .padding(8)
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 3)
                        
                        Text(location.name)
                            .font(.caption)
                            .padding(4)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(4)
                    }
                }
            }
            .navigationTitle("Educational Locations")
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
    
    private func iconForType(_ type: String) -> String {
        switch type {
        case "library": return "books.vertical.fill"
        case "museum": return "building.columns.fill"
        case "center": return "person.3.fill"
        case "workshop": return "hammer.fill"
        default: return "mappin"
        }
    }
    
    private func colorForType(_ type: String) -> Color {
        switch type {
        case "library": return .blue
        case "museum": return .purple
        case "center": return .green
        case "workshop": return .orange
        default: return .red
        }
    }
}

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let type: String
}

#Preview {
    ResourcesView()
} 