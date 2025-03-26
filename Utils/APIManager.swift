import Foundation
import CoreLocation

class APIManager {
    // Singleton instance
    static let shared = APIManager()
    
    // API Keys - should be stored securely in production
    private var googleMapsAPIKey: String = "YOUR_GOOGLE_MAPS_API_KEY"
    private var xAPIKey: String = "YOUR_X_API_KEY"
    private var khanAcademyAPIKey: String = "YOUR_KHAN_ACADEMY_API_KEY"
    private var wyzantAPIKey: String = "YOUR_WYZANT_API_KEY"
    
    private init() {}
    
    // MARK: - Google Maps API
    
    /// Get nearby educational resources based on location
    func getNearbyEducationalResources(latitude: Double, longitude: Double, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=1500&type=library|museum|school&key=\(googleMapsAPIKey)"
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "APIManager", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "APIManager", code: 500, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    completion(json, nil)
                } else {
                    completion(nil, NSError(domain: "APIManager", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON format"]))
                }
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    // MARK: - X API (formerly Twitter)
    
    /// Get social insights related to homeschooling topics
    func getHomeschoolingSocialInsights(topic: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let encodedTopic = topic.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.twitter.com/2/tweets/search/recent?query=\(encodedTopic)&max_results=10"
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "APIManager", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(xAPIKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "APIManager", code: 500, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    completion(json, nil)
                } else {
                    completion(nil, NSError(domain: "APIManager", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON format"]))
                }
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    // MARK: - Khan Academy API
    
    /// Get curriculum resources from Khan Academy
    func getKhanAcademyCurriculum(subject: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        // Note: Khan Academy has a GraphQL API that would need to be properly integrated
        // This is a simplified example
        let urlString = "https://www.khanacademy.org/api/v1/topic/\(subject)"
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "APIManager", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "APIManager", code: 500, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    completion(json, nil)
                } else {
                    completion(nil, NSError(domain: "APIManager", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON format"]))
                }
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    // MARK: - Wyzant API
    
    /// Find tutors through Wyzant
    func findTutors(subject: String, zipCode: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        // Note: This is a simplified example of Wyzant integration
        let urlString = "https://api.wyzant.com/api/v1/tutors?subject=\(subject)&zip_code=\(zipCode)"
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "APIManager", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(wyzantAPIKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "APIManager", code: 500, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    completion(json, nil)
                } else {
                    completion(nil, NSError(domain: "APIManager", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON format"]))
                }
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
} 