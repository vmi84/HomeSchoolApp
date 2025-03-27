import SwiftUI

struct Resource: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var url: String
    var category: String
}

struct SavedCourse: Identifiable {
    let id = UUID()
    var name: String
    var progress: Double
    var color: Color
}

struct ActivityItem: Identifiable {
    let id = UUID()
    var title: String
    var time: String
    var icon: String
    var color: Color
    var details: String
}

struct ResourcesView: View {
    @State private var searchText = ""
    @State private var showAddResource = false
    @State private var selectedResource: Resource?
    @State private var resources: [Resource] = [
        Resource(name: "Khan Academy", description: "Free online courses", url: "https://khanacademy.org", category: "General"),
        Resource(name: "Wyzant", description: "Find a tutor", url: "https://wyzant.com", category: "Tutoring"),
        Resource(name: "Study Materials", description: "Course materials", url: "https://example.com", category: "Materials")
    ]
    
    let savedCourses: [SavedCourse] = [
        SavedCourse(name: "Mathematics", progress: 0.7, color: .blue),
        SavedCourse(name: "Reading", progress: 0.5, color: .green),
        SavedCourse(name: "Writing", progress: 0.3, color: .orange),
        SavedCourse(name: "Science", progress: 0.4, color: .purple),
        SavedCourse(name: "Geography", progress: 0.2, color: .red),
        SavedCourse(name: "Grammar", progress: 0.6, color: .yellow)
    ]
    
    @State private var recentActivity: [ActivityItem] = [
        ActivityItem(title: "Completed Math Quiz", time: "2 hours ago", icon: "checkmark.circle.fill", color: .green, details: "Algebra Basics"),
        ActivityItem(title: "Started Science Course", time: "5 hours ago", icon: "play.circle.fill", color: .blue, details: "Physics Fundamentals"),
        ActivityItem(title: "Booked Tutoring Session", time: "1 day ago", icon: "calendar", color: .orange, details: "English Writing")
    ]
    
    var body: some View {
        NavigationStack {
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
                                ForEach(resources) { resource in
                                    ResourceCard(resource: resource)
                                        .onTapGesture {
                                            selectedResource = resource
                                        }
                                }
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
                                ForEach(savedCourses) { course in
                                    CourseCard(course: course)
                                }
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
                            ForEach(recentActivity) { activity in
                                ActivityRow(activity: activity)
                                    .onTapGesture {
                                        // Handle activity selection
                                    }
                            }
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
            .navigationTitle("Resource Nexus")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddResource = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddResource) {
                AddResourceView(resources: $resources)
            }
            .sheet(item: $selectedResource) { resource in
                ResourceDetailView(resource: resource)
            }
        }
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
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct ResourceCard: View {
    let resource: Resource
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(resource.name)
                .font(.headline)
            
            Text(resource.description)
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

struct CourseCard: View {
    let course: SavedCourse
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(course.name)
                .font(.headline)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(Color.secondary.opacity(0.2))
                        .frame(height: 8)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .foregroundColor(course.color)
                        .frame(width: geometry.size.width * course.progress, height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
            
            Text("\(Int(course.progress * 100))% Complete")
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

struct ActivityRow: View {
    let activity: ActivityItem
    
    var body: some View {
        HStack {
            Image(systemName: activity.icon)
                .foregroundColor(activity.color)
            
            VStack(alignment: .leading) {
                Text(activity.title)
                    .font(.subheadline)
                Text(activity.time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}

struct AddResourceView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var resources: [Resource]
    @State private var name = ""
    @State private var description = ""
    @State private var url = ""
    @State private var category = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Resource Name", text: $name)
                TextField("Description", text: $description)
                TextField("URL", text: $url)
                TextField("Category", text: $category)
            }
            .navigationTitle("Add Resource")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Add") {
                    let resource = Resource(name: name, description: description, url: url, category: category)
                    resources.append(resource)
                    dismiss()
                }
                .disabled(name.isEmpty || description.isEmpty || url.isEmpty || category.isEmpty)
            )
        }
    }
}

struct ResourceDetailView: View {
    let resource: Resource
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text(resource.description)
                    .font(.body)
                
                Link(destination: URL(string: resource.url)!) {
                    Text("Visit Resource")
                        .foregroundColor(.blue)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(resource.name)
            .navigationBarItems(trailing: Button("Done") {
                // Dismiss
            })
        }
    }
}

#Preview {
    ResourcesView()
} 