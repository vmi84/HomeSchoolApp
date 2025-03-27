import SwiftUI

struct ConnectionsView: View {
    @State private var searchText = ""
    @State private var showAddContact = false
    @State private var showCreateGroup = false
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Contacts")) {
                    ForEach(0..<5) { _ in
                        ContactRow()
                    }
                }
                
                Section(header: Text("Groups")) {
                    ForEach(0..<3) { _ in
                        GroupRow()
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search contacts")
            .navigationTitle("Connections")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: { showAddContact = true }) {
                            Label("Add Contact", systemImage: "person.badge.plus")
                        }
                        
                        Button(action: { showCreateGroup = true }) {
                            Label("Create Group", systemImage: "person.3")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddContact) {
                AddContactView()
            }
            .sheet(isPresented: $showCreateGroup) {
                CreateGroupView()
            }
        }
    }
}

struct ContactRow: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .font(.title2)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                Text("Contact Name")
                    .font(.headline)
                Text("Last message")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("2m ago")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct GroupRow: View {
    var body: some View {
        HStack {
            Image(systemName: "person.3.fill")
                .font(.title2)
                .foregroundColor(.green)
            
            VStack(alignment: .leading) {
                Text("Group Name")
                    .font(.headline)
                Text("3 members")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("1h ago")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var email = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
            .navigationTitle("Add Contact")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Add") {
                    // Add contact logic here
                    dismiss()
                }
                .disabled(name.isEmpty || email.isEmpty)
            )
        }
    }
}

struct CreateGroupView: View {
    @Environment(\.dismiss) var dismiss
    @State private var groupName = ""
    @State private var selectedContacts: Set<Int> = []
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Group Name", text: $groupName)
                
                Section(header: Text("Select Contacts")) {
                    ForEach(0..<5) { index in
                        Toggle("Contact \(index + 1)", isOn: Binding(
                            get: { selectedContacts.contains(index) },
                            set: { isSelected in
                                if isSelected {
                                    selectedContacts.insert(index)
                                } else {
                                    selectedContacts.remove(index)
                                }
                            }
                        ))
                    }
                }
            }
            .navigationTitle("Create Group")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Create") {
                    // Create group logic here
                    dismiss()
                }
                .disabled(groupName.isEmpty || selectedContacts.isEmpty)
            )
        }
    }
}

#Preview {
    ConnectionsView()
}
