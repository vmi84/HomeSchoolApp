import SwiftUI
import SwiftData
import Foundation
import CoreLocation
import MapKit

// Make imports available throughout the app
@_exported import struct HomeSchoolApp.AuthenticationService
@_exported import struct HomeSchoolApp.ServiceManager
@_exported import struct HomeSchoolApp.Connection

// Stub Firebase Core
#if DEBUG
enum FirebaseApp {
    static func configure() {
        print("Firebase configured (stub)")
    }
}
#endif 