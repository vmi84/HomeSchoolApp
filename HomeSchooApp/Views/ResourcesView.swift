import SwiftUI

struct ResourcesView: View {
    @State private var searchText = ""
    
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
                VStack(alignment: .leading, spacing: 20) {
                    // Featured resources carousel
                    VStack(alignment: .leading) {
                        Text("Featured Resources")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(0..<4) { index in
                                    FeaturedResourceCard(
                                        title: "Featured Resource \(index + 1)",
                                        description: "Khan Academy Algebra Course",
                                        image: "book.fill",
                                        color: index % 2 == 0 ? "blue" : "purple"
                                    )
                                    .frame(width: 280, height: 160)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Resource categories
                    VStack(alignment: .leading) {
                        Text("Browse by Category")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 15) {
                            ForEach(resourceCategories) { category in
                                ResourceCategoryCard(category: category)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // API integration sections
                    VStack(alignment: .leading) {
                        Text("External Learning Resources")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        VStack(spacing: 15) {
                            ApiResourceCard(
                                title: "Khan Academy",
                                description: "Access thousands of free lessons",
                                icon: "graduationcap.fill",
                                color: "green"
                            )
                            
                            ApiResourceCard(
                                title: "Wyzant Tutoring",
                                description: "Connect with expert tutors",
                                icon: "person.fill.questionmark",
                                color: "blue"
                            )
                            
                            ApiResourceCard(
                                title: "Educational Maps",
                                description: "Find nearby educational resources",
                                icon: "map.fill",
                                color: "orange"
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Resource Nexus")
            .searchable(text: $searchText, prompt: "Search resources")
        }
    }
}

struct ResourceCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: String
    let count: Int
}

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
            RoundedRectangle(cornerRadius: 12)
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
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(color))
        )
    }
}

struct ApiResourceCard: View {
    let title: String
    let description: String
    let icon: String
    let color: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(Color(color))
                .frame(width: 60)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 5)
        )
    }
}

#Preview {
    ResourcesView()
} 