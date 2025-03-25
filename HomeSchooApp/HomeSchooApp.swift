import SwiftUI
import SwiftData
import FirebaseCore

@main
struct HomeSchooApp: App {
    let container: ModelContainer
    
    init() {
        do {
            let schema = Schema([UserSubject.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Failed to initialize ModelContainer")
        }
        
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
} 