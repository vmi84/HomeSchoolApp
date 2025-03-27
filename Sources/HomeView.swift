import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: SettingsViewModel
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
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 15) {
                    // Student Profile Section
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Student Name")
                                    .font(.title3)
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
                        } else {
                            NavigationLink(destination: Text("Select Learning Style")) {
                                HStack {
                                    Image(systemName: "brain.head.profile")
                                        .foregroundColor(.blue)
                                    Text("Select Learning Style")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    // Active Subjects
                    VStack(alignment: .leading, spacing: 12) {
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
                        
                        VStack(spacing: 8) {
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
                .padding(.vertical, 10)
            }
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("Home")
            .sheet(item: $selectedSubject) { subject in
                SubjectDetailView(subject: subject, subjects: $subjects)
            }
        }
    }
}

struct Subject: Identifiable {
    let id = UUID()
    var name: String
    var progress: Double
    let color: Color
}

struct SubjectCard: View {
    let subject: Subject
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(subject.name)
                    .font(.headline)
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(Color.secondary.opacity(0.2))
                            .frame(height: 4)
                            .cornerRadius(2)
                        
                        Rectangle()
                            .foregroundColor(subject.color)
                            .frame(width: geometry.size.width * subject.progress, height: 4)
                            .cornerRadius(2)
                    }
                }
                .frame(height: 4)
                
                Text("\(Int(subject.progress * 100))% Complete")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
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
    @Environment(\.dismiss) var dismiss
    let subject: Subject
    @Binding var subjects: [Subject]
    @State private var progress: Double
    @State private var notes: String = ""
    
    init(subject: Subject, subjects: Binding<[Subject]>) {
        self.subject = subject
        self._subjects = subjects
        _progress = State(initialValue: subject.progress)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Progress Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Progress")
                            .font(.headline)
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .foregroundColor(Color.secondary.opacity(0.2))
                                    .frame(height: 8)
                                    .cornerRadius(4)
                                
                                Rectangle()
                                    .foregroundColor(subject.color)
                                    .frame(width: geometry.size.width * progress, height: 8)
                                    .cornerRadius(4)
                            }
                        }
                        .frame(height: 8)
                        
                        HStack {
                            Text("\(Int(progress * 100))% Complete")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Slider(value: $progress, in: 0...1)
                                .frame(width: 200)
                        }
                    }
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(15)
                    
                    // Notes Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Notes")
                            .font(.headline)
                        
                        TextEditor(text: $notes)
                            .frame(height: 100)
                            .padding(8)
                            .background(Color.secondary.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationTitle(subject.name)
            .navigationBarItems(trailing: Button("Done") {
                // Update the subject's progress in the subjects array
                if let index = subjects.firstIndex(where: { $0.id == subject.id }) {
                    subjects[index].progress = progress
                }
                dismiss()
            })
        }
    }
}

#Preview {
    HomeView()
} 