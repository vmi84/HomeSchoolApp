import SwiftUI
import SwiftData

struct SubjectPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var showingCustomSubjectSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(PredefinedSubject.allCases, id: \.self) { subject in
                        Button(action: {
                            addSubject(subject)
                        }) {
                            HStack {
                                Image(systemName: subject.icon)
                                    .foregroundStyle(Color(subject.color))
                                Text(subject.rawValue)
                                Spacer()
                                Image(systemName: "plus.circle.fill")
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                } header: {
                    Text("Available Subjects")
                }
                
                Section {
                    Button(action: {
                        showingCustomSubjectSheet = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundStyle(.blue)
                            Text("Add Custom Subject")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Add Subject")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingCustomSubjectSheet) {
                CustomSubjectView()
            }
        }
    }
    
    private func addSubject(_ subject: PredefinedSubject) {
        let newSubject = UserSubject(
            name: subject.rawValue,
            icon: subject.icon,
            color: subject.color
        )
        modelContext.insert(newSubject)
        dismiss()
    }
}

struct CustomSubjectView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var name = ""
    @State private var selectedIcon = "book"
    @State private var selectedColor = "blue"
    
    let icons = ["book", "pencil", "star", "heart", "flag", "tag", "bookmark", "person", "house", "globe", "doc"]
    let colors = ["blue", "green", "purple", "orange", "pink", "red", "indigo", "teal", "mint", "brown", "gray"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Subject Name", text: $name)
                }
                
                Section("Icon") {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))], spacing: 10) {
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .font(.title2)
                                .frame(width: 44, height: 44)
                                .background(selectedIcon == icon ? Color(selectedColor).opacity(0.2) : Color.clear)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .onTapGesture {
                                    selectedIcon = icon
                                }
                        }
                    }
                }
                
                Section("Color") {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))], spacing: 10) {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(Color(color))
                                .frame(width: 44, height: 44)
                                .overlay(
                                    Circle()
                                        .stroke(Color.primary, lineWidth: selectedColor == color ? 2 : 0)
                                )
                                .onTapGesture {
                                    selectedColor = color
                                }
                        }
                    }
                }
            }
            .navigationTitle("Custom Subject")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addCustomSubject()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    private func addCustomSubject() {
        let newSubject = UserSubject(
            name: name,
            icon: selectedIcon,
            color: selectedColor,
            isCustom: true
        )
        modelContext.insert(newSubject)
        dismiss()
    }
}

#Preview {
    SubjectPickerView()
        .modelContainer(for: UserSubject.self, inMemory: true)
} 