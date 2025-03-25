import SwiftUI
import SwiftData
import Charts

struct StudentProgressView: View {
    @Query private var subjects: [UserSubject]
    @State private var selectedTimeFrame = TimeFrame.week
    @State private var showingAddAssessment = false
    
    // Sample data
    private let weeklyProgress: [ProgressEntry] = [
        ProgressEntry(day: "Mon", value: 65),
        ProgressEntry(day: "Tue", value: 72),
        ProgressEntry(day: "Wed", value: 68),
        ProgressEntry(day: "Thu", value: 80),
        ProgressEntry(day: "Fri", value: 85),
        ProgressEntry(day: "Sat", value: 78),
        ProgressEntry(day: "Sun", value: 90)
    ]
    
    private let assessments: [Assessment] = [
        Assessment(subject: "Mathematics", score: 92, date: "Mar 22, 2025", type: "Quiz"),
        Assessment(subject: "Science", score: 87, date: "Mar 20, 2025", type: "Lab Report"),
        Assessment(subject: "English", score: 95, date: "Mar 18, 2025", type: "Essay")
    ]
    
    private let achievements: [Achievement] = [
        Achievement(title: "Math Master", description: "Completed all algebra modules", date: "Mar 15, 2025", icon: "function"),
        Achievement(title: "Science Explorer", description: "Conducted 10 experiments", date: "Mar 10, 2025", icon: "atom"),
        Achievement(title: "Reading Champion", description: "Read 5 books this month", date: "Mar 5, 2025", icon: "book")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    // Overall progress section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Overall Progress")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack {
                            Picker("Time Frame", selection: $selectedTimeFrame) {
                                ForEach(TimeFrame.allCases, id: \.self) { timeFrame in
                                    Text(timeFrame.rawValue)
                                }
                            }
                            .pickerStyle(.segmented)
                            
                            Spacer()
                        }
                        
                        ProgressChartView(entries: weeklyProgress)
                            .frame(height: 220)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                    )
                    .padding(.horizontal)
                    
                    // Subject breakdown section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Subject Breakdown")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        if subjects.isEmpty {
                            ContentUnavailableView(
                                "No Subjects",
                                systemImage: "book.closed",
                                description: Text("Add subjects to track progress")
                            )
                            .frame(height: 150)
                        } else {
                            ForEach(subjects) { subject in
                                SubjectProgressBar(subject: subject)
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                    )
                    .padding(.horizontal)
                    
                    // Recent assessments section
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text("Recent Assessments")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {
                                showingAddAssessment = true
                            }) {
                                Label("Add", systemImage: "plus")
                                    .font(.callout)
                            }
                            .buttonStyle(.bordered)
                        }
                        
                        ForEach(assessments) { assessment in
                            AssessmentCard(assessment: assessment)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                    )
                    .padding(.horizontal)
                    
                    // Achievements section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Recent Achievements")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        ForEach(achievements) { achievement in
                            AchievementCard(achievement: achievement)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                    )
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("GrowEasy Analytics")
            .sheet(isPresented: $showingAddAssessment) {
                AddAssessmentView()
            }
        }
    }
}

enum TimeFrame: String, CaseIterable {
    case week = "Week"
    case month = "Month"
    case semester = "Semester"
    case year = "Year"
}

struct ProgressEntry: Identifiable {
    let id = UUID()
    let day: String
    let value: Double
}

struct Assessment: Identifiable {
    let id = UUID()
    let subject: String
    let score: Int
    let date: String
    let type: String
}

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let date: String
    let icon: String
}

struct ProgressChartView: View {
    let entries: [ProgressEntry]
    
    var body: some View {
        VStack {
            Chart {
                ForEach(entries) { entry in
                    BarMark(
                        x: .value("Day", entry.day),
                        y: .value("Progress", entry.value)
                    )
                    .foregroundStyle(Color.blue.gradient)
                    .cornerRadius(8)
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Average")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text("\(averageProgress(), specifier: "%.1f")%")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Trend")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        Image(systemName: "arrow.up.right")
                        Text("+12%")
                            .fontWeight(.bold)
                    }
                    .foregroundStyle(.green)
                }
            }
        }
    }
    
    private func averageProgress() -> Double {
        let sum = entries.reduce(0.0) { $0 + $1.value }
        return sum / Double(entries.count)
    }
}

struct SubjectProgressBar: View {
    let subject: UserSubject
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: subject.icon)
                .font(.title3)
                .foregroundStyle(Color(subject.color))
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(subject.name)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("\(Int(subject.progress * 100))%")
                        .font(.callout)
                        .fontWeight(.semibold)
                }
                
                ProgressView(value: subject.progress)
                    .tint(Color(subject.color))
            }
        }
    }
}

struct AssessmentCard: View {
    let assessment: Assessment
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(assessment.subject)
                    .font(.headline)
                
                Text("\(assessment.type) • \(assessment.date)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(scoreColor.opacity(0.2), lineWidth: 4)
                    .frame(width: 45, height: 45)
                
                Circle()
                    .trim(from: 0, to: CGFloat(assessment.score) / 100)
                    .stroke(scoreColor, lineWidth: 4)
                    .frame(width: 45, height: 45)
                    .rotationEffect(.degrees(-90))
                
                Text("\(assessment.score)")
                    .font(.callout)
                    .fontWeight(.bold)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 3)
        )
    }
    
    private var scoreColor: Color {
        switch assessment.score {
        case 90...100: return .green
        case 80..<90: return .blue
        case 70..<80: return .yellow
        default: return .red
        }
    }
}

struct AchievementCard: View {
    let achievement: Achievement
    
    var body: some View {
        HStack {
            Image(systemName: achievement.icon)
                .font(.largeTitle)
                .foregroundStyle(.yellow)
                .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(achievement.title)
                    .font(.headline)
                
                Text(achievement.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(achievement.date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "trophy.fill")
                .foregroundStyle(.yellow)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 3)
        )
    }
}

struct AddAssessmentView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var subject = ""
    @State private var score = 80.0
    @State private var assessmentType = "Quiz"
    
    private let assessmentTypes = ["Quiz", "Test", "Project", "Homework", "Essay", "Lab Report"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Subject", text: $subject)
                    
                    Picker("Type", selection: $assessmentType) {
                        ForEach(assessmentTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Score: \(Int(score))")
                        Slider(value: $score, in: 0...100, step: 1)
                    }
                }
                
                Section {
                    Button("Save Assessment") {
                        // Save the assessment
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Add Assessment")
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
    StudentProgressView()
        .modelContainer(for: UserSubject.self, inMemory: true)
} 