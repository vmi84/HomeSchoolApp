import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query private var userSubjects: [UserSubject]
    @State private var showingEditProfile = false
    @State private var showingSubjectPicker = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Header
                    VStack(spacing: 12) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(.blue)
                        
                        Text("Student Name")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Grade Level")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    
                    // Learning Compass
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Learning Compass")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {
                                showingSubjectPicker = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title3)
                            }
                        }
                        
                        if userSubjects.isEmpty {
                            ContentUnavailableView(
                                "No Subjects",
                                systemImage: "book.closed",
                                description: Text("Add subjects to start tracking your learning journey")
                            )
                            .frame(height: 200)
                        } else {
                            ForEach(userSubjects) { subject in
                                SubjectProgressRow(subject: subject)
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 5)
                    )
                    .padding(.horizontal)
                    
                    // Additional sections would go here
                }
            }
            .navigationTitle("Learning Compass")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingEditProfile = true
                    }) {
                        Text("Edit")
                    }
                }
            }
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView()
            }
            .sheet(isPresented: $showingSubjectPicker) {
                SubjectPickerView()
            }
        }
    }
}

struct SubjectProgressRow: View {
    let subject: UserSubject
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: subject.icon)
                    .font(.headline)
                    .foregroundStyle(Color(subject.color))
                
                Text(subject.name)
                    .font(.headline)
                
                Spacer()
                
                Text("\(Int(subject.progress * 100))%")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            ProgressView(value: subject.progress)
                .tint(Color(subject.color))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(subject.color).opacity(0.1))
        )
    }
}

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var studentName = "Student Name"
    @State private var gradeLevel = "Grade Level"
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Student Name", text: $studentName)
                    TextField("Grade Level", text: $gradeLevel)
                }
                
                Section {
                    Button("Save") {
                        // Save profile changes
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Edit Profile")
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
    ProfileView()
        .modelContainer(for: UserSubject.self, inMemory: true)
} 