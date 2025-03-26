import SwiftUI
import MapKit
import SwiftData
import Foundation

struct ConnectionsView: View {
    @EnvironmentObject var authService: AuthenticationService
    @StateObject private var serviceManager = ServiceManager.shared
    @State private var selectedTab = 0
    @State private var searchText = ""
    @State private var showingAddConnection = false
    @State private var showingFilter = false
    @State private var selectedFilter = ConnectionFilter.all
    
    enum ConnectionFilter: String, CaseIterable, Identifiable {
        case all = "All"
        case tutors = "Tutors"
        case parents = "Parents"
        case groups = "Groups"
        
        var id: String { rawValue }
    }
    
    var filteredConnections: [Connection] {
        var connections = serviceManager.connections
        
        if !searchText.isEmpty {
            connections = connections.filter { connection in
                connection.name.localizedCaseInsensitiveContains(searchText) ||
                connection.type.rawValue.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        switch selectedFilter {
        case .all:
            return connections
        case .tutors:
            return connections.filter { $0.type == .tutor }
        case .parents:
            return connections.filter { $0.type == .parent }
        case .groups:
            return connections.filter { $0.type == .group }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search bar
                SearchBar(text: $searchText)
                    .padding()
                
                // Filter tabs
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(ConnectionFilter.allCases) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                // Connections list
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(filteredConnections) { connection in
                            ConnectionCard(connection: connection)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("HomeLink")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddConnection = true
                    } label: {
                        Image(systemName: "person.badge.plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingFilter = true
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .sheet(isPresented: $showingAddConnection) {
                AddConnectionView()
            }
            .sheet(isPresented: $showingFilter) {
                FilterView(selectedFilter: $selectedFilter)
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search connections...", text: $text)
                .textFieldStyle(.plain)
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct ConnectionCard: View {
    let connection: Connection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: connection.type.icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(connection.type.color)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(connection.name)
                        .font(.headline)
                    
                    Text(connection.type.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            
            if let bio = connection.bio {
                Text(bio)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            if let subjects = connection.subjects {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(subjects, id: \.self) { subject in
                            Text(subject)
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(connection.type.color.opacity(0.1))
                                .foregroundColor(connection.type.color)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 8)
        )
    }
}

struct AddConnectionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var type: Connection.ConnectionType = .tutor
    @State private var bio = ""
    @State private var subjects: [String] = []
    @State private var showingSubjectPicker = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Information") {
                    TextField("Name", text: $name)
                    
                    Picker("Type", selection: $type) {
                        ForEach(Connection.ConnectionType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    
                    TextField("Bio", text: $bio, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section("Subjects") {
                    ForEach(subjects, id: \.self) { subject in
                        Text(subject)
                    }
                    .onDelete { indexSet in
                        subjects.remove(atOffsets: indexSet)
                    }
                    
                    Button {
                        showingSubjectPicker = true
                    } label: {
                        Label("Add Subject", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Add Connection")
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
                        // TODO: Add connection
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .sheet(isPresented: $showingSubjectPicker) {
                SubjectPickerView(selectedSubjects: $subjects)
            }
        }
    }
}

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedFilter: ConnectionsView.ConnectionFilter
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(ConnectionsView.ConnectionFilter.allCases) { filter in
                    Button {
                        selectedFilter = filter
                        dismiss()
                    } label: {
                        HStack {
                            Text(filter.rawValue)
                            
                            Spacer()
                            
                            if selectedFilter == filter {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Filter")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
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
    ConnectionsView()
        .environmentObject(AuthenticationService())
} 