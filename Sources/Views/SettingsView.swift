import SwiftUI

struct LearningStyle: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
    var isCustom: Bool = false
}

struct Goal: Identifiable, Codable {
    let id = UUID()
    var text: String
}

class SettingsViewModel: ObservableObject {
    @Published var selectedLearningStyle: LearningStyle?
    @Published var goals: [Goal] = []
    @Published var customLearningStyle: String = ""
    @Published var showLearningStylePicker = false
    @Published var showAddGoal = false
    @Published var newGoalText = ""
    
    let learningStyles = [
        LearningStyle(name: "Visual", description: "Learn best through seeing"),
        LearningStyle(name: "Auditory", description: "Learn best through hearing"),
        LearningStyle(name: "Reading/Writing", description: "Learn best through reading and writing"),
        LearningStyle(name: "Kinesthetic", description: "Learn best through hands-on, tactile experiences"),
        LearningStyle(name: "Logical/Mathematical", description: "Learn best through logic and reasoning"),
        LearningStyle(name: "Social/Interpersonal", description: "Learn best in groups or with others"),
        LearningStyle(name: "Solitary/Intrapersonal", description: "Learn best working alone"),
        LearningStyle(name: "Other", description: "Custom learning style", isCustom: true)
    ]
    
    func addGoal() {
        guard !newGoalText.isEmpty && goals.count < 10 else { return }
        goals.append(Goal(text: newGoalText))
        newGoalText = ""
    }
    
    func removeGoal(at index: Int) {
        goals.remove(at: index)
    }
}

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showCustomStyleInput = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Learning Style")) {
                    Button(action: {
                        viewModel.showLearningStylePicker = true
                    }) {
                        HStack {
                            Text("Current Learning Style")
                            Spacer()
                            Text(viewModel.selectedLearningStyle?.name ?? "Not Selected")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section(header: Text("Current Goals")) {
                    ForEach(viewModel.goals) { goal in
                        Text(goal.text)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { viewModel.removeGoal(at: $0) }
                    }
                    
                    if viewModel.goals.count < 10 {
                        Button(action: {
                            viewModel.showAddGoal = true
                        }) {
                            Label("Add Goal", systemImage: "plus.circle.fill")
                        }
                    }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(Version.full)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $viewModel.showLearningStylePicker) {
                NavigationView {
                    List(viewModel.learningStyles) { style in
                        Button(action: {
                            viewModel.selectedLearningStyle = style
                            if style.isCustom {
                                showCustomStyleInput = true
                            }
                            viewModel.showLearningStylePicker = false
                        }) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(style.name)
                                        .font(.headline)
                                    Text(style.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                if viewModel.selectedLearningStyle?.id == style.id {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    .navigationTitle("Select Learning Style")
                    .navigationBarItems(trailing: Button("Cancel") {
                        viewModel.showLearningStylePicker = false
                    })
                }
            }
            .sheet(isPresented: $viewModel.showAddGoal) {
                NavigationView {
                    Form {
                        TextField("Enter new goal", text: $viewModel.newGoalText)
                    }
                    .navigationTitle("Add New Goal")
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            viewModel.showAddGoal = false
                        },
                        trailing: Button("Add") {
                            viewModel.addGoal()
                            viewModel.showAddGoal = false
                        }
                        .disabled(viewModel.newGoalText.isEmpty)
                    )
                }
            }
            .alert("Custom Learning Style", isPresented: $showCustomStyleInput) {
                TextField("Enter learning style", text: $viewModel.customLearningStyle)
                Button("Cancel", role: .cancel) {}
                Button("Save") {
                    if !viewModel.customLearningStyle.isEmpty {
                        viewModel.selectedLearningStyle = LearningStyle(
                            name: viewModel.customLearningStyle,
                            description: "Custom learning style",
                            isCustom: true
                        )
                    }
                }
            } message: {
                Text("Please enter your custom learning style")
            }
        }
    }
} 