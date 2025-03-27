import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var selectedSubject: Subject?
    @State private var showAddSubject = false
    @State private var newSubjectName = ""
    @State private var subjects: [Subject] = [
        Subject(name: "Mathematics", progress: 0.7, color: .blue),
        Subject(name: "Science", progress: 0.5, color: .green),
        Subject(name: "English", progress: 0.3, color: .orange)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Student Profile Section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Student Name")
                                    .font(.title2)
                                    .bold()
                                Text("Grade Level")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        if let learningStyle = viewModel.selectedLearningStyle {
                            HStack {
                                Image(systemName: "brain.head.profile")
                                    .foregroundColor(.blue)
                                Text("Learning Style: \(learningStyle.name)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    // Active Subjects
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text("Active Subjects")
                                .font(.title3)
                                .bold()
                            
                            Spacer()
                            
                            NavigationLink(destination: SubjectSettingsView(subjects: $subjects)) {
                                Image(systemName: "gear")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            ForEach(subjects) { subject in
                                SubjectCard(subject: subject)
                                    .onTapGesture {
                                        selectedSubject = subject
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("Home")
            .sheet(item: $selectedSubject) { subject in
                SubjectDetailView(subject: subject)
            }
        }
    }
}

struct Subject: Identifiable {
    let id = UUID()
    let name: String
    let progress: Double
    let color: Color
}

struct SubjectCard: View {
    let subject: Subject
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(subject.name)
                    .font(.headline)
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(Color.secondary.opacity(0.2))
                            .frame(height: 6)
                            .cornerRadius(3)
                        
                        Rectangle()
                            .foregroundColor(subject.color)
                            .frame(width: geometry.size.width * subject.progress, height: 6)
                            .cornerRadius(3)
                    }
                }
                .frame(height: 6)
                
                Text("\(Int(subject.progress * 100))% Complete")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(15)
    }
}

struct SubjectSettingsView: View {
    @Binding var subjects: [Subject]
    @State private var newSubjectName = ""
    
    var body: some View {
        List {
            Section(header: Text("Add New Subject")) {
                HStack {
                    TextField("Subject Name", text: $newSubjectName)
                    
                    Button(action: {
                        if !newSubjectName.isEmpty {
                            let subject = Subject(
                                name: newSubjectName,
                                progress: 0.0,
                                color: [.blue, .green, .orange, .purple, .red].randomElement() ?? .blue
                            )
                            subjects.append(subject)
                            newSubjectName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                    .disabled(newSubjectName.isEmpty)
                }
            }
            
            Section(header: Text("Current Subjects")) {
                ForEach(subjects) { subject in
                    HStack {
                        Text(subject.name)
                        Spacer()
                        Button(action: {
                            if let index = subjects.firstIndex(where: { $0.id == subject.id }) {
                                subjects.remove(at: index)
                            }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
                .onMove { from, to in
                    subjects.move(fromOffsets: from, toOffset: to)
                }
            }
        }
        .navigationTitle("Subject Settings")
        .toolbar {
            EditButton()
        }
    }
}

struct SubjectDetailView: View {
    let subject: Subject
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Subject Details")
                        .font(.title2)
                        .bold()
                    
                    Text("This is a detailed view for \(subject.name). Add more content here.")
                        .foregroundColor(.gray)
                }
                .padding()
            }
            .navigationTitle(subject.name)
            .navigationBarItems(trailing: Button("Done") {
                // Dismiss
            })
        }
    }
}

#Preview {
    HomeView()
} 