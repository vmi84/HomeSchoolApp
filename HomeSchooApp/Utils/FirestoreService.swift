import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirestoreService {
    static let shared = FirestoreService()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    // MARK: - User Profile Methods
    
    /// Create a new user profile in Firestore after registration
    func createUserProfile(userId: String, email: String, completion: @escaping (Error?) -> Void) {
        let userData: [String: Any] = [
            "email": email,
            "createdAt": Timestamp(date: Date()),
            "lastLogin": Timestamp(date: Date()),
            "displayName": "",
            "profileCompleted": false
        ]
        
        db.collection("users").document(userId).setData(userData) { error in
            completion(error)
        }
    }
    
    /// Update user profile information
    func updateUserProfile(userId: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        db.collection("users").document(userId).updateData(data) { error in
            completion(error)
        }
    }
    
    /// Get user profile data
    func getUserProfile(userId: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        db.collection("users").document(userId).getDocument { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let snapshot = snapshot, snapshot.exists else {
                completion(nil, NSError(domain: "FirestoreService", code: 404, userInfo: [NSLocalizedDescriptionKey: "User profile not found"]))
                return
            }
            
            completion(snapshot.data(), nil)
        }
    }
    
    // MARK: - Subject Methods
    
    /// Save a subject to Firestore
    func saveSubject(userId: String, subject: UserSubject, completion: @escaping (Error?) -> Void) {
        let subjectData: [String: Any] = [
            "id": subject.id.uuidString,
            "name": subject.name,
            "icon": subject.icon,
            "color": subject.color,
            "progress": subject.progress,
            "isCustom": subject.isCustom,
            "updatedAt": Timestamp(date: Date())
        ]
        
        db.collection("users").document(userId).collection("subjects").document(subject.id.uuidString).setData(subjectData) { error in
            completion(error)
        }
    }
    
    /// Get all subjects for a user
    func getSubjects(userId: String, completion: @escaping ([UserSubject]?, Error?) -> Void) {
        db.collection("users").document(userId).collection("subjects").getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion([], nil)
                return
            }
            
            let subjects = documents.compactMap { document -> UserSubject? in
                let data = document.data()
                
                guard let idString = data["id"] as? String,
                      let id = UUID(uuidString: idString),
                      let name = data["name"] as? String,
                      let icon = data["icon"] as? String,
                      let color = data["color"] as? String,
                      let progress = data["progress"] as? Double,
                      let isCustom = data["isCustom"] as? Bool else {
                    return nil
                }
                
                let subject = UserSubject(name: name, icon: icon, color: color, progress: progress, isCustom: isCustom)
                subject.id = id
                return subject
            }
            
            completion(subjects, nil)
        }
    }
    
    /// Delete a subject
    func deleteSubject(userId: String, subjectId: String, completion: @escaping (Error?) -> Void) {
        db.collection("users").document(userId).collection("subjects").document(subjectId).delete { error in
            completion(error)
        }
    }
    
    // MARK: - Learning Goals Methods
    
    /// Save a learning goal
    func saveLearningGoal(userId: String, goal: [String: Any], completion: @escaping (String?, Error?) -> Void) {
        var goalData = goal
        goalData["createdAt"] = Timestamp(date: Date())
        goalData["updatedAt"] = Timestamp(date: Date())
        
        let goalRef = db.collection("users").document(userId).collection("learningGoals").document()
        goalData["id"] = goalRef.documentID
        
        goalRef.setData(goalData) { error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            completion(goalRef.documentID, nil)
        }
    }
    
    /// Get all learning goals for a user
    func getLearningGoals(userId: String, completion: @escaping ([[String: Any]]?, Error?) -> Void) {
        db.collection("users").document(userId).collection("learningGoals")
            .order(by: "dueDate", descending: false)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion([], nil)
                    return
                }
                
                let goals = documents.map { $0.data() }
                completion(goals, nil)
            }
    }
    
    /// Update a learning goal
    func updateLearningGoal(userId: String, goalId: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        var updatedData = data
        updatedData["updatedAt"] = Timestamp(date: Date())
        
        db.collection("users").document(userId).collection("learningGoals").document(goalId).updateData(updatedData) { error in
            completion(error)
        }
    }
    
    /// Delete a learning goal
    func deleteLearningGoal(userId: String, goalId: String, completion: @escaping (Error?) -> Void) {
        db.collection("users").document(userId).collection("learningGoals").document(goalId).delete { error in
            completion(error)
        }
    }
} 