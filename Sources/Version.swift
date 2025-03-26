enum Version {
    static let current = "0.3.1"
    static let build = "1"
    
    static var full: String {
        return "\(current) (\(build))"
    }
} 