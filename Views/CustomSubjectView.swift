import SwiftUI
import SwiftData

struct CustomSubjectView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var icon = "book"
    @State private var color = "blue"
    
    let icons = ["book", "pencil", "paintpalette", "music.note", "function", "atom", "figure.run", "laptopcomputer"]
    let colors = ["blue", "green", "purple", "orange", "pink", "red", "indigo", "teal"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Subject Name", text: $name)
                }
                
                Section("Icon") {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))], spacing: 10) {
                        ForEach(icons, id: \.self) { iconName in
                            Image(systemName: iconName)
                                .font(.title2)
                                .frame(width: 44, height: 44)
                                .background(icon == iconName ? Color.accentColor.opacity(0.2) : Color.clear)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .onTapGesture {
                                    icon = iconName
                                }
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section("Color") {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))], spacing: 10) {
                        ForEach(colors, id: \.self) { colorName in
                            Circle()
                                .fill(Color(colorName))
                                .frame(width: 44, height: 44)
                                .overlay(
                                    Circle()
                                        .stroke(Color.accentColor, lineWidth: color == colorName ? 2 : 0)
                                )
                                .onTapGesture {
                                    color = colorName
                                }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Custom Subject")
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
                    Button("Add") {
                        let subject = UserSubject(name: name, icon: icon, color: color, isCustom: true)
                        modelContext.insert(subject)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
} 