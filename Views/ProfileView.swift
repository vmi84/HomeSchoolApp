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
                            Label("Learning Compass", systemImage: "compass.drawing")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {
                                showingSubjectPicker = true
                            }) {
                                Label("Add Subject", systemImage: "plus.circle.fill")
                                    .font(.subheadline)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .clipShape(Capsule())
                            }
                        }
                        
                        Text("Your personalized learning journey")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        if userSubjects.isEmpty {
                            ContentUnavailableView(
                                "No Subjects",
                                systemImage: "book.closed",
                                description: Text("Add subjects to start tracking your learning journey")
                            )
                            .frame(height: 200)
                        } else {
                            VStack(spacing: 12) {
                                ForEach(userSubjects) { subject in
                                    SubjectProgressRow(subject: subject)
                                }
                            }
                        }
                        
                        // Learning Goal Section
                        VStack(alignment: .leading, spacing: 12) {
                            Label("Learning Goals", systemImage: "target")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            LearningGoalRow(
                                title: "Complete Math Module 3",
                                dueDate: "July 30, 2024", 
                                progress: 0.65
                            )
                            
                            LearningGoalRow(
                                title: "Read 'The Giver'",
                                dueDate: "August 10, 2024", 
                                progress: 0.25
                            )
                            
                            Button(action: {
                                // Add learning goal action
                            }) {
                                Text("+ Add Learning Goal")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                            .padding(.top, 4)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                    
                    // Learning Stats
                    VStack(alignment: .leading, spacing: 16) {
                        Label("Learning Insights", systemImage: "chart.bar.xaxis")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(alignment: .top, spacing: 20) {
                            StatCard(
                                title: "Focus Time",
                                value: "12.5",
                                unit: "hours",
                                icon: "clock",
                                color: .blue
                            )
                            
                            StatCard(
                                title: "Completed",
                                value: "8",
                                unit: "lessons",
                                icon: "checkmark.circle",
                                color: .green
                            )
                            
                            StatCard(
                                title: "Streak",
                                value: "5",
                                unit: "days",
                                icon: "flame",
                                color: .orange
                            )
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                }
                .padding(.bottom, 20)
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
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(subject.color).opacity(0.1))
        )
    }
}

struct LearningGoalRow: View {
    let title: String
    let dueDate: String
    let progress: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text(dueDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            ProgressView(value: progress)
                .tint(.purple)
            
            Text("\(Int(progress * 100))% Complete")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.purple.opacity(0.1))
        )
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let unit: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            
            Text(unit)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(color.opacity(0.1))
        )
    }
}

#Preview {
    ProfileView()
        .modelContainer(for: UserSubject.self, inMemory: true)
} 