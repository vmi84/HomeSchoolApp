import SwiftUI

public struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var studentName = ""
    @State private var gradeLevel = ""
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Student Name", text: $studentName)
                    TextField("Grade Level", text: $gradeLevel)
                }
            }
            .navigationTitle("Edit Profile")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
        }
    }
} 