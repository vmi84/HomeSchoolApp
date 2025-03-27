import SwiftUI

struct LearningStyle: Identifiable, Codable {
    var id: UUID
    let name: String
    let description: String
    var isCustom: Bool
    
    init(id: UUID = UUID(), name: String, description: String, isCustom: Bool = false) {
        self.id = id
        self.name = name
        self.description = description
        self.isCustom = isCustom
    }
}

struct Goal: Identifiable, Codable {
    var id: UUID
    var text: String
    
    init(id: UUID = UUID(), text: String) {
        self.id = id
        self.text = text
    }
}

class SettingsViewModel: ObservableObject {
    @Published var selectedLearningStyle: LearningStyle? {
        didSet {
            saveSettings()
        }
    }
    @Published var goals: [Goal] = [] {
        didSet {
            saveSettings()
        }
    }
    @Published var customLearningStyle: String = ""
    @Published var showLearningStylePicker = false
    @Published var showAddGoal = false
    @Published var newGoalText = ""
    @Published var colorScheme: ColorScheme? {
        didSet {
            saveSettings()
        }
    }
    
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
    
    init() {
        loadSettings()
    }
    
    func addGoal() {
        guard !newGoalText.isEmpty && goals.count < 10 else { return }
        goals.append(Goal(text: newGoalText))
        newGoalText = ""
    }
    
    func removeGoal(at index: Int) {
        goals.remove(at: index)
    }
    
    func saveSettings() {
        if let encoded = try? JSONEncoder().encode(goals) {
            UserDefaults.standard.set(encoded, forKey: "userGoals")
        }
        if let encoded = try? JSONEncoder().encode(selectedLearningStyle) {
            UserDefaults.standard.set(encoded, forKey: "selectedLearningStyle")
        }
        if let colorScheme = colorScheme {
            UserDefaults.standard.set(colorScheme == .dark ? "dark" : "light", forKey: "colorScheme")
        }
    }
    
    private func loadSettings() {
        if let data = UserDefaults.standard.data(forKey: "userGoals"),
           let decoded = try? JSONDecoder().decode([Goal].self, from: data) {
            goals = decoded
        }
        if let data = UserDefaults.standard.data(forKey: "selectedLearningStyle"),
           let decoded = try? JSONDecoder().decode(LearningStyle.self, from: data) {
            selectedLearningStyle = decoded
        }
        if let savedScheme = UserDefaults.standard.string(forKey: "colorScheme") {
            colorScheme = savedScheme == "dark" ? .dark : .light
        }
    }
}

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showCustomStyleInput = false
    @State private var showSaveConfirmation = false
    @Environment(\.colorScheme) private var systemColorScheme
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")) {
                    Picker("Theme", selection: $viewModel.colorScheme) {
                        Text("System").tag(Optional<ColorScheme>.none)
                        Text("Light").tag(Optional<ColorScheme>.some(.light))
                        Text("Dark").tag(Optional<ColorScheme>.some(.dark))
                    }
                }
                
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.saveSettings()
                        showSaveConfirmation = true
                    }
                }
            }
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
            .alert("Settings Saved", isPresented: $showSaveConfirmation) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Your settings have been saved successfully.")
            }
        }
        .preferredColorScheme(viewModel.colorScheme ?? systemColorScheme)
    }
} 