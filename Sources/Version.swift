enum Version {
    static let current = "0.3.3"
    static let build = "1"
    
    static var full: String {
        return "\(current) (\(build))"
    }
} 