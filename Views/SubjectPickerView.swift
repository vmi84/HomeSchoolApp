import SwiftUI
import SwiftData

struct SubjectPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedSubjects: [String]
    
    private let availableSubjects = [
        "Mathematics",
        "Science",
        "Language Arts",
        "History",
        "Geography",
        "Art",
        "Music",
        "Physical Education",
        "Computer Science",
        "Foreign Languages"
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(availableSubjects, id: \.self) { subject in
                    Button {
                        if selectedSubjects.contains(subject) {
                            selectedSubjects.removeAll { $0 == subject }
                        } else {
                            selectedSubjects.append(subject)
                        }
                    } label: {
                        HStack {
                            Text(subject)
                            
                            Spacer()
                            
                            if selectedSubjects.contains(subject) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Subjects")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SubjectPickerView(selectedSubjects: .constant(["Mathematics", "Science"]))
} 