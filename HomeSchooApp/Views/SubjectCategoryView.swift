import SwiftUI
import SwiftData

struct SubjectCategoryView: View {
    let category: SubjectCategory
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            ForEach(PredefinedSubject.allCases.filter { $0.category == category }, id: \.self) { subject in
                Button {
                    let userSubject = UserSubject(
                        name: subject.rawValue,
                        icon: subject.icon,
                        color: subject.color,
                        isCustom: false
                    )
                    modelContext.insert(userSubject)
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: subject.icon)
                            .foregroundStyle(Color(subject.color))
                        Text(subject.rawValue)
                    }
                }
            }
        }
        .navigationTitle(category.rawValue)
    }
} 